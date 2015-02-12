module Position
  QUARTERBACK = "qb"
  RUNNINGBACK = "rb"
  WIDERECEIVER = "wr"
  TIGHTEND = "te"
  DEFENSE = "def"
  KICKER = "k"
  FLEX = "flex"
  ALL_STRING = "all"

  SKILL_POSITIONS = [Position::RUNNINGBACK, Position::WIDERECEIVER, Position::TIGHTEND]

  ALL_POSITIONS = [Position::QUARTERBACK,
                    Position::RUNNINGBACK,
                    Position::WIDERECEIVER,
                    Position::TIGHTEND,
                    Position::DEFENSE,
                    Position::KICKER]

  ALL_POSITION_INCLUDING_FLEX = [Position::QUARTERBACK,
                                  Position::RUNNINGBACK,
                                  Position::WIDERECEIVER,
                                  Position::TIGHTEND,
                                  Position::DEFENSE,
                                  Position::KICKER,
                                  Position::FLEX]

  ALL_POSITION_INCLUDING_FLEX_AND_ALL = [Position::ALL_STRING,
                                          Position::QUARTERBACK,
                                          Position::RUNNINGBACK,
                                          Position::WIDERECEIVER,
                                          Position::TIGHTEND,
                                          Position::DEFENSE,
                                          Position::KICKER,
                                          Position::FLEX]
end
