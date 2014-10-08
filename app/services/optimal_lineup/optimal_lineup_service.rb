module OptimalLineup
  class OptimalLineupService

    def initialize(week = 1)
      @week = week
    end

    def get_best_lineup qb_keep, qb_reject, rb_keep, rb_reject, wr_keep, wr_reject, te_keep, te_reject, k_keep, k_reject, d_keep, d_reject
      qb = LineupOptimize::PlayerSalaryInformation.new("QB", @week)
      rbs = LineupOptimize::PlayerSalaryInformation.new("RB", @week)
      wrs = LineupOptimize::PlayerSalaryInformation.new("WR", @week)
      te = LineupOptimize::PlayerSalaryInformation.new("TE", @week)
      k = LineupOptimize::PlayerSalaryInformation.new("K", @week)
      dst = LineupOptimize::PlayerSalaryInformation.new("DST", @week)

      qb.set_players_to_keep(qb_keep)
      qb.set_players_to_remove(qb_reject)

      rbs.set_players_to_keep(rb_keep)
      rbs.set_players_to_remove(rb_reject)

      wrs.set_players_to_keep(wr_keep)
      wrs.set_players_to_remove(wr_reject)

      te.set_players_to_keep(te_keep)
      te.set_players_to_remove(te_reject)

      k.set_players_to_keep(k_keep)
      k.set_players_to_remove(k_reject)

      dst.set_players_to_keep(d_keep)
      dst.set_players_to_remove(d_reject)

      filtered_qbs = qb.filter_down_data
      filtered_rbs = rbs.filter_down_data
      filtered_wrs = wrs.filter_down_data
      filtered_tes = te.filter_down_data
      filtered_ds = dst.filter_down_data
      filtered_ks = k.filter_down_data

      max_salary = 60000
      top = { projection: 0, player_ids: [] }

      filtered_qbs.each do |qb|
        qb_salary = qb[0]

        filtered_rbs.each do |rb|
          rb_salary = qb_salary + rb[0]
          next if rb_salary > max_salary

          filtered_wrs.each do |wr|
            wr_salary = rb_salary + wr[0]
            next if wr_salary > max_salary

            filtered_tes.each do |te|
              te_salary = wr_salary + te[0]
              next if te_salary > max_salary

              filtered_ds.each do |d|
                d_salary = te_salary + d[0]
                next if d_salary > max_salary

                filtered_ks.each do |k|
                  salary = d_salary + k[0]
                  next if salary > max_salary

                  projection = qb[1] + rb[1] + wr[1] + te[1] + d[1] + k[1]

                  if projection > top[:projection]
                    ids = [qb[2], rb[2], rb[3], wr[2], wr[3], wr[4], te[2], d[2], k[2]]
                    top = { projection: projection, player_ids: ids }
                  end
                end
              end
            end
          end
        end
      end

      top
    end

  end

end
