require 'nokogiri'
require 'open-uri'

module Spotrac
  class SpotracService

    def self.scrape_site
      process_spotrac_team_data
      process_spotrac_player_data
      process_spotrac_salary_data
    end

    def self.process_spotrac_team_data
      base_url = "http://www.spotrac.com/nfl/"

      page = Nokogiri::HTML(open(base_url))
      page.css("a.team-name").each do |team|
        set_spotrac_team_url(team.attributes["href"].value, team.text)
      end
    end

    def self.process_spotrac_player_data
      NflTeam.all.each do |nfl_team|
        puts "processing: " + nfl_team.full_name + " " + nfl_team.spotrac_url

        nfl_page = Nokogiri::HTML(open(nfl_team.spotrac_url))
        nfl_page.css("table.datatable").css("tr").each do |player|
          position_node = player.css("td")[1]
          name_node = player.css("td")[0]

          next if name_node.nil?
          next if position_node.nil?
          next if name_node.children[1].attributes["href"].nil?
          next unless Position::ALL_POSITIONS.include? position_node.text.downcase

          href = name_node.children[1].attributes["href"].text
          set_nfl_player_spotrac_url(name_node.children[1].text, position_node.text, href, nfl_team)
        end
      end
    end

    def self.process_spotrac_salary_data
      NflPlayer.find_each do |player|
        next if player.full_name == "Kevin Norwood"
        next if player.full_name == "Rueben Randle"
        next if player.full_name == "Chris Givens"
        next if player.full_name == "David Cobb"
        next if player.full_name == "Brandon Tate"
        next if player.full_name == "Jerome Simpson"
        next if player.full_name == "Gerald Christian"
        next if player.full_name == "Austin Davis"
        next if player.full_name == "Sean Renfree"

        puts "processing: " + player.full_name
        player.update_spotrac_salary
      end

      save_all_teams_updating_their_total_salary
    end

  private

    def self.save_all_teams_updating_their_total_salary
      # calling save so that it will update
      # each fantasy teams overal total salary
      # just in case someones salary changed
      Team.all.each do |t|
        t.save
      end
    end

    def self.set_nfl_player_spotrac_url(full_name, position, href, nfl_team)
      player = NflPlayer.fuzzy_find_by_spotrac(full_name, position.downcase, nfl_team)
      return nil if player.nil?

      player.spotrac_url = href
      player.save
    end

    def self.set_spotrac_team_url(href, team_name)
      team = NflTeam.find_by(full_name: team_name)
      if team.nil?
        team_name = team_name.delete '.'
        team = NflTeam.find_by(full_name: team_name)
      end

      return nil if team.nil?

      team.spotrac_url = href
      team.save
    end

  end

end
