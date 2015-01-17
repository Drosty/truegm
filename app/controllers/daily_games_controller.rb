class DailyGamesController < ApplicationController
  layout "daily"

  # get /daily
  def index
  end

  # post /daily
  def optimize
    week = "7"
    ol_service = OptimalLineup::OptimalLineupService.new(week)
    lineup = ol_service.get_best_lineup(params["qbs_allowed"], params["qbs_reject"],
                                         params["rbs_allowed"], params["rbs_reject"],
                                         params["wrs_allowed"], params["wrs_reject"],
                                         params["tes_allowed"], params["tes_reject"],
                                         params["ks_allowed"], params["ks_reject"],
                                         params["dsts_allowed"], params["dsts_reject"])

    lineup_data_models = PlayerSalaryInformation.where("id in (?)", lineup[:player_ids]).sort

    @qb  = lineup_data_models.select { |l| l.position == "QB" }[0]
    @rb1 = lineup_data_models.select { |l| l.position == "RB" }[0]
    @rb2 = lineup_data_models.select { |l| l.position == "RB" }[1]
    @wr1 = lineup_data_models.select { |l| l.position == "WR" }[0]
    @wr2 = lineup_data_models.select { |l| l.position == "WR" }[1]
    @wr3 = lineup_data_models.select { |l| l.position == "WR" }[2]
    @te  = lineup_data_models.select { |l| l.position == "TE" }[0]
    @k   = lineup_data_models.select { |l| l.position == "K" }[0]
    @d   = lineup_data_models.select { |l| l.position == "DST" }[0]
    @projection = lineup[:projection]
  end

  def daily_info
    @week = "7"
    @qbs  = PlayerSalaryInformation.where("position = 'QB'  AND week = #{@week}")
    @rbs  = PlayerSalaryInformation.where("position = 'RB'  AND week = #{@week}")
    @wrs  = PlayerSalaryInformation.where("position = 'WR'  AND week = #{@week}")
    @tes  = PlayerSalaryInformation.where("position = 'TE'  AND week = #{@week}")
    @ks   = PlayerSalaryInformation.where("position = 'K'  AND week = #{@week}")
    @dsts = PlayerSalaryInformation.where("position = 'DST'  AND week = #{@week}")
  end

end
