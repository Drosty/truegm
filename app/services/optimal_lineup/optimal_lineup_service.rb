module OptimalLineup
  class OptimalLineupService

    def initialize(week = 1)
      @week = week
    end

    def get_best_lineup
      qb = LineupOptimize::PlayerSalaryInformation.new("QB", @week)
      rbs = LineupOptimize::PlayerSalaryInformation.new("RB", @week)
      wrs = LineupOptimize::PlayerSalaryInformation.new("WR", @week)
      te = LineupOptimize::PlayerSalaryInformation.new("TE", @week)
      k = LineupOptimize::PlayerSalaryInformation.new("K", @week)
      dst = LineupOptimize::PlayerSalaryInformation.new("DST", @week)

      filtered_qbs = qb.filter_down_data
      filtered_rbs = qb.filter_down_data
      filtered_wrs = qb.filter_down_data
      filtered_tes = qb.filter_down_data
      filtered_ds = qb.filter_down_data
      filtered_ks = qb.filter_down_data

      top_10 = []
      lowest_projection = 0

      binding.pry
=begin
      # 75MM total combinations combinations (much much better than thousands of trillions)
      filtered_qbs.each do |qb|
        filtered_rbs.each do |rb|
          filtered_wrs.each do |wr|
            filtered_tes.each do |te|
              filtered_ds.each do |d|
                filtered_ks.each do |k|
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
=end

    end

  end

end
