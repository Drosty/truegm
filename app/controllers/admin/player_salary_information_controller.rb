module Admin
  class PlayerSalaryInformationController < BaseController

    def index
      @max_week = PlayerSalaryInformation.select(&:week).map(&:week).max
      @salaries = PlayerSalaryInformation.where(week: @max_week)
    end

    def new
    end

    def create
      week = params["week"].to_i

      if !week || week < 0 || week > 17
        redirect_to admin_salaries_path, alert: "File not processed.  Invalid Week"
      end

      file = params["salary_file"]
      file.open
      info = file.read

      data = CSV.parse(info, headers: true)

      PlayerSalaryInformation.where(week: week).delete_all

      data.each do |salary_data|
        if salary_data["Salary"].to_i > 0 && salary_data["Projection"].to_i > 0
          PlayerSalaryInformation.find_or_create_by(player_name: salary_data["Player"],
                                                    position: salary_data["Pos"],
                                                    salary: salary_data["Salary"],
                                                    week: week,
                                                    projection: salary_data["Projection"])
        end
      end

      redirect_to admin_salaries_path, alert: "File Import Processed"
    end

    def process_salaries
      week = PlayerSalaryInformation.select(&:week).map(&:week).max
      db_qbs = PlayerSalaryInformation.where("position = 'QB' AND week = #{week}")
      db_rbs = PlayerSalaryInformation.where("position = 'RB' AND week = #{week}")
      db_wrs = PlayerSalaryInformation.where("position = 'WR' AND week = #{week}")
      db_tes = PlayerSalaryInformation.where("position = 'TE' AND week = #{week}")
      db_ks = PlayerSalaryInformation.where("position = 'K' AND week = #{week}")
      db_ds = PlayerSalaryInformation.where("position = 'DST' AND week = #{week}")

      mapped_qbs = db_qbs.map { |qb| [qb.salary, qb.projection, qb.id] }
      mapped_rbs = db_rbs.map { |rb| [rb.salary, rb.projection, rb.id] }
      mapped_wrs = db_wrs.map { |wr| [wr.salary, wr.projection, wr.id] }
      mapped_tes = db_tes.map { |te| [te.salary, te.projection, te.id] }
      mapped_ks = db_ks.map { |k| [k.salary, k.projection, k.id] }
      mapped_ds = db_ds.map { |d| [d.salary, d.projection, d.id] }

      rb_combinations = mapped_rbs.combination(2)
      wr_combinations = mapped_wrs.combination(3)

      # 4084256961859074 combinations here
      # 9715134000
      # 31007592
      binding.pry

      filtered_qbs = filter_down_data(mapped_qbs, false)
      filtered_rbs = filter_down_data(rb_combinations, true)
      filtered_wrs = filter_down_data(wr_combinations, true)
      filtered_tes = filter_down_data(mapped_tes, false)
      filtered_ks = filter_down_data(mapped_ks, false)
      filtered_ds = filter_down_data(mapped_ds, false)

      filtered_qbs = filtered_qbs.select { |l| (l[1]*1000)/l[0] > 2.0 }
      filtered_rbs = filtered_rbs.select { |l| (l[1]*1000)/l[0] > 0.90 }
      filtered_wrs = filtered_wrs.select { |l| (l[1]*1000)/l[0] > 0.80 }
      filtered_tes = filtered_tes.select { |l| (l[1]*1000)/l[0] > 0.75 }
      filtered_ks = filtered_ks.select { |l| (l[1]*1000)/l[0] > 1.0 }
      filtered_ds = filtered_ds.select { |l| (l[1]*1000)/l[0] > 1.0 }

      top_10 = []
      lowest_projection = 0

      # 75MM total combinations combinations (much much better than Trillions)
      filtered_qbs.each do |qb|
        puts "new QB"
        filtered_rbs.each do |rb|
          filtered_wrs.each do |wr|
            filtered_tes.each do |te|
              filtered_ds.each do |d|
                filtered_ks.each do |k|
                  lineup = [qb, rb, wr, te, d, k]

                  salary = qb[0] + rb[0] + wr[0] + te[0] + d[0] + k[0]
                  next if salary > 60000

                  projection = qb[1] + rb[1] + wr[1] + te[1] + d[1] + k[1]

                  if projection > lowest_projection
                    ids = [qb[2], rb[2], rb[3], wr[2], wr[3], wr[4], te[2], d[2], k[2]]
                    top_10 << { projection: projection, player_ids: ids }

                    top_10 = top_10.sort_by { |hash| hash[:projection] }

                    if top_10.length > 25
                      top_10.shift
                    end

                    lowest_projection = top_10[0][:projection]
                  end
                end
              end
            end
          end
        end
      end

      binding.pry

    end

    def optimal_lineup
    end

    private

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

      def filter_down_data players, is_combination
        player_data = []

        if is_combination
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
        filtered_down_players = []

        last_player_record_processed = [0,0]
        player_data.each do |data|
          # data[1] is projection
          if data[1] > last_player_record_processed[1]
            filtered_down_players << data
            last_player_record_processed = data
          end
        end

        filtered_down_players.reverse
      end

  end

end
