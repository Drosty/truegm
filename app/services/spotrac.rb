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
        get_teams_from_spotrac(team.attributes["href"].value, team.text)
      end
    end

    def self.process_spotrac_player_data
      NflTeam.all.each do |nfl_team|
        puts "processing: " + nfl_team.location + " " + nfl_team.mascot

	        nfl_page = Nokogiri::HTML(open(nfl_team.spotrac_url))
	        nfl_page.css("table#teamTable").css("tr").each do |player|
          position_node = player.css("td")[1]
          name_node = player.css("td")[0]
          next if name_node.nil?
          next if position_node.nil?
          next unless ["QB", "RB", "WR", "TE", "K"].include? position_node.text

          href = name_node.children[0].attributes["href"].text
          get_nfl_player_from_spotrac(name_node.text, position_node.text, href, nfl_team)
        end
      end
    end

    def self.process_spotrac_salary_data
      NflPlayer.all.find_each do |player|
        puts "processing: " + player.full_name
        next if player.spotrac_url.nil?
        player_page = Nokogiri::HTML(open(player.spotrac_url))
        salary_node = player_page.css("table.salaryTable").css("tr.salaryRow").css("td.salaryAmt").css("span.bold")[0]
        next if salary_node.nil?
        player.salary = salary_node.text.delete(',').strip
        player.save
      end
    end

  private

    def self.get_nfl_player_from_spotrac(full_name, position, href, nfl_team)
      player = NflPlayer.find_by(full_name: full_name, position: position, nfl_team: nfl_team)
      player = NflPlayer.new if player.nil?
      player.full_name = full_name
      player.position = position
      player.spotrac_url = href
      player.nfl_team = nfl_team
      player.save
    end

    def self.get_teams_from_spotrac( href, team_name)
      mascot = team_name.split.last
      location = team_name.split.first

      if team_name.split.count > 2
        location = team_name.split[0] + " " + team_name.split[1]
      end

      team = NflTeam.find_by(mascot: mascot, location: location)
      team = NflTeam.new if team.nil?
      team.mascot = mascot
      team.location = location
      team.spotrac_url = href
      team.save
    end
  end

end
