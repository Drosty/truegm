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
        puts "processing: " + nfl_team.location + " " + nfl_team.mascot + " " + nfl_team.spotrac_url

        nfl_page = Nokogiri::HTML(open(nfl_team.spotrac_url))
        nfl_page.css("table#teamTable").css("tr").each do |player|
          position_node = player.css("td")[1]
          name_node = player.css("td")[0]

          next if name_node.nil?
          next if position_node.nil?
          next if name_node.children[1].attributes["href"].nil?
          next unless ["qb", "rb", "wr", "te", "k"].include? position_node.text.downcase

          href = name_node.children[1].attributes["href"].text
          set_nfl_player_spotrac_url(name_node.children[1].text, position_node.text, href, nfl_team)
        end
      end
    end

    def self.process_spotrac_salary_data
      NflPlayer.all.find_each do |player|
        next if player.spotrac_url.nil?
        puts "processing: " + player.full_name

        player_page = Nokogiri::HTML(open(player.spotrac_url))
        salary_node = player_page.css("table.salaryTable").css("tr.salaryRow").css("td.salaryAmt").css("span.bold")[0]

        next if salary_node.nil?

        player.salary = salary_node.text.delete(',').strip
        player.save
      end
    end

  private

    def self.set_nfl_player_spotrac_url(full_name, position, href, nfl_team)
      player = NflPlayer.fuzzy_find_by_spotrac(full_name, position.downcase, nfl_team)
      return nil if player.nil?

      player.spotrac_url = href
      player.save
    end

    def self.set_spotrac_team_url(href, team_name)
      puts "GOING TO HAVE TO UPDATE THIS WHOLE CLASS!!!!"

      parts = team_name.split

      mascot = parts.last
      parts.delete(mascot)
      location = parts.join(' ') if parts.is_a? Array
      location = parts if parts.is_a? String

      if team_name.split.count > 2
        location = team_name.split[0] + " " + team_name.split[1]
      end

      team = NflTeam.find_by(mascot: mascot, location: location)
      return nil if team.nil?

      team.spotrac_url = href
      team.save
    end

  end

end
