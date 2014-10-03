module LineupOptimize
  class PlayerSalaryInformation

    def initialize position, week
      @position = position
      @week = week

      @players_to_keep   = []
      @players_to_remove = []

      db_players = ::PlayerSalaryInformation.where("position = '#{@position.upcase}'  AND week = #{@week}")
      @mapped_players = db_players.map { |player| [player.salary, player.projection, player.id] }
    end

    def set_players_to_keep player_array = []
      @players_to_keep = player_array
    end

    def set_players_to_remove player_array = []
      @players_to_remove = player_array
    end

    def filter_down_data
      player_data = player_combination_array
      last_player_record_processed = [0,0]

      filtered_down_players = []
      player_data.each do |data|
        # data[1] is projection
        if data[1] > last_player_record_processed[1]
          filtered_down_players << data
          last_player_record_processed = data
        end
      end

      filtered_down_players = filtered_down_players.select { |l| (l[1]*1000)/l[0] > filter_threshold }
      filtered_down_players = filtered_down_players.reverse
      filtered_down_players
    end

    private

      def filter_threshold
        return 2.0 if @position == "QB"
        return 0.9 if @position == "QB"
        return 0.8 if @position == "QB"
        return 0.75 if @position == "QB"
        1.0
      end

      def player_combination_array
        player_data = []
        players = []
        if do_combinations?
          players = @mapped_players.combination(number_of_combinations).to_a
        else
          players = @mapped_players.to_a
        end
        
        if do_combinations?
          players.each do |comb|
            salary = get_salary_from_player_combination(comb)
            projection = get_projection_from_player_combination(comb)
            ids = get_ids_from_player_combination(comb)

            array = [salary, projection, ids].flatten
            player_data << array
          end
        else
          player_data = players.to_a
        end

        player_data.sort!.uniq!
        player_data
      end

      def number_of_combinations
        return 2 if @position == "RB"
        return 3 if @position == "WR"
        1
      end

      def do_combinations?
        number_of_combinations > 1
      end

      def get_salary_from_player_combination combination
        salary = combination[0][0] + combination[1][0]
        salary = salary + combination[2][0] if combination.length > 2
        salary
      end

      def get_projection_from_player_combination combination
        projection = combination[0][1].to_f + combination[1][1].to_f
        projection = projection + combination[2][1].to_f if combination.length > 2
        projection
      end

      def get_ids_from_player_combination combination
        ids = [combination[0][2], combination[1][2]]
        ids << combination[2][2] if combination.length > 2
        ids
      end

  end
end
