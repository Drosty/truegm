# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160902171310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "draft_picks", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "year"
    t.integer  "round"
    t.integer  "position"
    t.integer  "original_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "draft_picks", ["original_team_id"], name: "draft_pick_original_team_fk", using: :btree
  add_index "draft_picks", ["team_id"], name: "draft_pick_current_team_fk", using: :btree

  create_table "external_links", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "external_links", ["user_id"], name: "link_url_fk", using: :btree

  create_table "forum_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "forum_topic_id"
    t.text     "post_body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_topics", force: :cascade do |t|
    t.integer  "league_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forumposts_count", default: 0
    t.integer  "user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.integer  "team_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kicking_stats", force: :cascade do |t|
    t.integer  "nfl_matchup_id"
    t.integer  "nfl_player_id"
    t.integer  "nfl_team_id"
    t.integer  "number"
    t.string   "position"
    t.string   "fantasy_position"
    t.float    "fantasy_points"
    t.integer  "extra_points_attempted"
    t.integer  "extra_points_made"
    t.float    "field_goal_percentage"
    t.integer  "field_goals_attempted"
    t.integer  "field_goals_longest_made"
    t.integer  "field_goals_made"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "week"
    t.integer  "season"
  end

  add_index "kicking_stats", ["nfl_matchup_id"], name: "index_kicking_stats_on_nfl_matchup_id", using: :btree
  add_index "kicking_stats", ["nfl_player_id"], name: "index_kicking_stats_on_nfl_player_id", using: :btree
  add_index "kicking_stats", ["nfl_team_id"], name: "index_kicking_stats_on_nfl_team_id", using: :btree

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "tagline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salary_cap"
    t.float    "passing_yard_points",                              default: 0.04
    t.integer  "passing_touchdown_points",                         default: 5
    t.float    "passing_interception_points",                      default: -2.0
    t.float    "fumbles_lost_points",                              default: -2.0
    t.float    "rushing_yards_points",                             default: 0.1
    t.integer  "rushing_touchdown_points",                         default: 6
    t.float    "receiving_yards_points",                           default: 0.1
    t.integer  "receiving_touchdown_points",                       default: 6
    t.float    "points_per_reception_points",                      default: 1.0
    t.float    "defensive_interception_points",                    default: 2.0
    t.float    "defensive_fumble_recovered_points",                default: 2.0
    t.integer  "defensive_sack_points",                            default: 1
    t.integer  "defensive_saftey_points",                          default: 2
    t.integer  "defensive_touchdown_points",                       default: 6
    t.float    "defensive_points_allowed_under_7_points",          default: 10.0
    t.float    "defensive_points_allowed_under_14_points",         default: 7.0
    t.float    "defensive_points_allowed_under_21_points",         default: 1.0
    t.float    "defensive_points_allowed_under_28_points",         default: 0.0
    t.float    "defensive_points_allowed_under_35_points",         default: -1.0
    t.float    "defensive_points_allowed_equal_or_over_35_points", default: -4.0
    t.integer  "min_team_players",                                 default: 14
    t.integer  "max_team_players",                                 default: 15
    t.integer  "starting_qb_slots",                                default: 1
    t.integer  "starting_rb_slots",                                default: 2
    t.integer  "starting_wr_slots",                                default: 2
    t.integer  "starting_te_slots",                                default: 1
    t.integer  "starting_d_slots",                                 default: 1
    t.integer  "starting_flex_wrte_slots",                         default: 0
    t.integer  "starting_flex_rbwrte_slots",                       default: 1
    t.integer  "starting_k_slots",                                 default: 1
    t.string   "player_salary_type",                               default: "real"
    t.integer  "ir_slots",                                         default: 1
    t.boolean  "ir_players_tradeable",                             default: false
    t.integer  "ir_cap_relief_max",                                default: 5000000
    t.boolean  "ir_re_activatable",                                default: false
    t.integer  "ir_reactivation_penalty",                          default: 0
    t.boolean  "configuration_editable",                           default: true
    t.integer  "playoffs_start_week",                              default: 13
  end

  create_table "matchups", force: :cascade do |t|
    t.integer  "year"
    t.integer  "week"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matchups", ["away_team_id"], name: "matchup_away_team_fk", using: :btree
  add_index "matchups", ["home_team_id"], name: "matchup_home_team_fk", using: :btree

  create_table "nfl_matchups", force: :cascade do |t|
    t.integer  "import_game_id"
    t.integer  "week"
    t.integer  "year"
    t.datetime "game_date"
    t.integer  "away_team_id"
    t.integer  "home_team_id"
    t.string   "tv_station"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "point_spread"
    t.float    "over_under"
    t.string   "game_key"
    t.integer  "away_score"
    t.integer  "home_score"
    t.integer  "quarter"
    t.string   "time_remaining",         default: "0:00"
    t.string   "possession"
    t.integer  "down"
    t.integer  "distance"
    t.integer  "yard_line"
    t.string   "yard_line_territory"
    t.boolean  "red_zone",               default: false
    t.integer  "away_score_quarter1"
    t.integer  "away_score_quarter2"
    t.integer  "away_score_quarter3"
    t.integer  "away_score_quarter4"
    t.integer  "away_score_overtime"
    t.integer  "home_score_quarter1"
    t.integer  "home_score_quarter2"
    t.integer  "home_score_quarter3"
    t.integer  "home_score_quarter4"
    t.integer  "home_score_overtime"
    t.boolean  "has_started",            default: false
    t.boolean  "is_in_progress",         default: false
    t.boolean  "is_over",                default: false
    t.boolean  "has1st_quarter_started", default: false
    t.boolean  "has2nd_quarter_started", default: false
    t.boolean  "has3rd_quarter_started", default: false
    t.boolean  "has4th_quarter_started", default: false
    t.boolean  "is_overtime",            default: false
    t.string   "down_and_distance",      default: "1st and 10"
    t.string   "quarter_description"
    t.datetime "last_updated"
  end

  create_table "nfl_players", force: :cascade do |t|
    t.integer  "nfl_team_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "position"
    t.integer  "salary",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotrac_url"
    t.string   "full_name"
    t.string   "jersey"
    t.string   "height"
    t.string   "weight"
    t.datetime "dob"
    t.string   "college"
    t.boolean  "active"
    t.string   "current_status"
    t.integer  "depth_order"
    t.integer  "experience"
    t.string   "photo_url"
    t.integer  "fantasy_data_id"
  end

  add_index "nfl_players", ["nfl_team_id"], name: "nfl_player_nfl_team_id", using: :btree

  create_table "nfl_players_teams", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "nfl_player_id"
  end

  add_index "nfl_players_teams", ["team_id", "nfl_player_id"], name: "by_team_and_player", unique: true, using: :btree

  create_table "nfl_teams", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotrac_url"
    t.string   "code"
    t.string   "full_name"
    t.string   "short_name"
    t.integer  "bye_week"
  end

  create_table "passing_stats", force: :cascade do |t|
    t.integer  "nfl_matchup_id"
    t.integer  "nfl_player_id"
    t.integer  "nfl_team_id"
    t.integer  "number"
    t.string   "position"
    t.string   "fantasy_position"
    t.float    "fantasy_points"
    t.integer  "passing_attempts"
    t.float    "passing_completion_percentage"
    t.integer  "passing_completions"
    t.integer  "passing_interceptions"
    t.integer  "passing_long"
    t.float    "passing_rating"
    t.integer  "passing_sack_yards"
    t.integer  "passing_sacks"
    t.integer  "passing_touchdowns"
    t.integer  "passing_yards"
    t.float    "passing_yards_per_attempt"
    t.float    "passing_yards_per_completion"
    t.integer  "two_point_conversion_passes"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "week"
    t.integer  "season"
  end

  add_index "passing_stats", ["nfl_matchup_id"], name: "index_passing_stats_on_nfl_matchup_id", using: :btree
  add_index "passing_stats", ["nfl_player_id"], name: "index_passing_stats_on_nfl_player_id", using: :btree
  add_index "passing_stats", ["nfl_team_id"], name: "index_passing_stats_on_nfl_team_id", using: :btree

  create_table "power_rankings", force: :cascade do |t|
    t.integer  "team_id"
    t.text     "description"
    t.integer  "rank"
    t.integer  "week"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "power_rankings", ["team_id"], name: "power_ranking_team_fk", using: :btree

  create_table "punting_stats", force: :cascade do |t|
    t.integer  "nfl_matchup_id"
    t.integer  "nfl_player_id"
    t.integer  "nfl_team_id"
    t.integer  "number"
    t.string   "position"
    t.string   "fantasy_position"
    t.float    "fantasy_points"
    t.float    "punt_average"
    t.integer  "punt_inside20"
    t.integer  "punt_touchbacks"
    t.integer  "punt_yards"
    t.integer  "punts"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "week"
    t.integer  "season"
  end

  add_index "punting_stats", ["nfl_matchup_id"], name: "index_punting_stats_on_nfl_matchup_id", using: :btree
  add_index "punting_stats", ["nfl_player_id"], name: "index_punting_stats_on_nfl_player_id", using: :btree
  add_index "punting_stats", ["nfl_team_id"], name: "index_punting_stats_on_nfl_team_id", using: :btree

  create_table "receiving_stats", force: :cascade do |t|
    t.integer  "nfl_matchup_id"
    t.integer  "nfl_player_id"
    t.integer  "nfl_team_id"
    t.integer  "number"
    t.string   "position"
    t.string   "fantasy_position"
    t.float    "fantasy_points"
    t.integer  "fumbles_lost"
    t.integer  "receiving_long"
    t.integer  "receiving_targets"
    t.integer  "receiving_touchdowns"
    t.integer  "receiving_yards"
    t.float    "receiving_yards_per_reception"
    t.float    "receiving_yards_per_target"
    t.float    "reception_percentage"
    t.integer  "receptions"
    t.integer  "two_point_conversion_receptions"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "week"
    t.integer  "season"
  end

  add_index "receiving_stats", ["nfl_matchup_id"], name: "index_receiving_stats_on_nfl_matchup_id", using: :btree
  add_index "receiving_stats", ["nfl_player_id"], name: "index_receiving_stats_on_nfl_player_id", using: :btree
  add_index "receiving_stats", ["nfl_team_id"], name: "index_receiving_stats_on_nfl_team_id", using: :btree

  create_table "return_stats", force: :cascade do |t|
    t.integer  "nfl_matchup_id"
    t.integer  "nfl_player_id"
    t.integer  "nfl_team_id"
    t.integer  "number"
    t.string   "position"
    t.string   "fantasy_position"
    t.float    "fantasy_points"
    t.integer  "kick_return_long"
    t.integer  "kick_return_touchdowns"
    t.integer  "kick_return_yards"
    t.float    "kick_return_yards_per_attempt"
    t.integer  "kick_returns"
    t.integer  "punt_return_long"
    t.integer  "punt_return_touchdowns"
    t.integer  "punt_return_yards"
    t.float    "punt_return_yards_per_attempt"
    t.integer  "punt_returns"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "week"
    t.integer  "season"
  end

  add_index "return_stats", ["nfl_matchup_id"], name: "index_return_stats_on_nfl_matchup_id", using: :btree
  add_index "return_stats", ["nfl_player_id"], name: "index_return_stats_on_nfl_player_id", using: :btree
  add_index "return_stats", ["nfl_team_id"], name: "index_return_stats_on_nfl_team_id", using: :btree

  create_table "rosters", force: :cascade do |t|
    t.string   "name"
    t.integer  "qb1"
    t.integer  "rb1"
    t.integer  "rb2"
    t.integer  "wr1"
    t.integer  "wr2"
    t.integer  "te"
    t.integer  "flex"
    t.integer  "utility"
    t.integer  "pk"
    t.integer  "bench1"
    t.integer  "bench2"
    t.integer  "bench3"
    t.integer  "bench4"
    t.integer  "bench5"
    t.integer  "bench6"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "salary"
  end

  create_table "rushing_stats", force: :cascade do |t|
    t.integer  "nfl_matchup_id"
    t.integer  "nfl_player_id"
    t.integer  "nfl_team_id"
    t.integer  "number"
    t.string   "position"
    t.string   "fantasy_position"
    t.float    "fantasy_points"
    t.integer  "fumbles_lost"
    t.integer  "rushing_attempts"
    t.integer  "rushing_long"
    t.integer  "rushing_touchdowns"
    t.integer  "rushing_yards"
    t.float    "rushing_yards_per_attempt"
    t.integer  "two_point_conversion_runs"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "week"
    t.integer  "season"
  end

  add_index "rushing_stats", ["nfl_matchup_id"], name: "index_rushing_stats_on_nfl_matchup_id", using: :btree
  add_index "rushing_stats", ["nfl_player_id"], name: "index_rushing_stats_on_nfl_player_id", using: :btree
  add_index "rushing_stats", ["nfl_team_id"], name: "index_rushing_stats_on_nfl_team_id", using: :btree

  create_table "stats", force: :cascade do |t|
    t.integer "nfl_player_id"
    t.integer "passing_yards"
    t.integer "passing_touchdowns"
    t.integer "rushing_yards"
    t.integer "rushing_touchdowns"
    t.integer "receptions"
    t.integer "receiving_yards"
    t.integer "receiving_touchdowns"
    t.integer "fumbles_lost"
    t.integer "year"
    t.integer "week"
    t.integer "tfl"
    t.integer "qbhits"
    t.integer "defensive_interceptions"
    t.integer "fumbles_recovered"
    t.integer "safties"
    t.integer "defensive_tds"
    t.integer "return_tds"
    t.integer "points_allowed"
    t.string  "opponent"
    t.string  "final_score"
    t.boolean "played"
    t.boolean "started"
    t.integer "passing_completions"
    t.integer "passing_attempts"
    t.float   "passing_percentage"
    t.float   "qb_rating"
    t.integer "rushing_attempts"
    t.float   "rushing_average"
    t.integer "long_run"
    t.integer "receiving_long"
    t.integer "passing_sacks"
    t.integer "defensive_sacks"
    t.integer "passing_interceptions"
    t.integer "receiving_targets"
    t.integer "two_point_conversion_receptions"
    t.integer "two_point_conversion_runs"
  end

  add_index "stats", ["nfl_player_id"], name: "index_stats_on_nfl_player_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "tagline"
    t.integer  "league_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_salary", default: 0
    t.string   "invite_code"
  end

  add_index "teams", ["league_id"], name: "team_league_fk", using: :btree
  add_index "teams", ["user_id"], name: "team_user_fk", using: :btree

  create_table "trade_items", force: :cascade do |t|
    t.integer  "trade_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "team"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trade_items", ["item_id", "item_type"], name: "index_trade_items_on_item_id_and_item_type", using: :btree
  add_index "trade_items", ["trade_id"], name: "trade_item_trade_fk", using: :btree

  create_table "trade_votes", force: :cascade do |t|
    t.integer  "trade_id"
    t.integer  "team_id"
    t.string   "vote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trade_votes", ["team_id"], name: "trade_vote_user_fk", using: :btree
  add_index "trade_votes", ["trade_id"], name: "trade_vote_trade_fk", using: :btree

  create_table "trades", force: :cascade do |t|
    t.integer  "from_team_id"
    t.integer  "to_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trades", ["from_team_id"], name: "trade_from_team_fk", using: :btree
  add_index "trades", ["to_team_id"], name: "trade_to_team_fk", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "is_admin"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "kicking_stats", "nfl_matchups"
  add_foreign_key "kicking_stats", "nfl_players"
  add_foreign_key "kicking_stats", "nfl_teams"
  add_foreign_key "passing_stats", "nfl_matchups"
  add_foreign_key "passing_stats", "nfl_players"
  add_foreign_key "passing_stats", "nfl_teams"
  add_foreign_key "punting_stats", "nfl_matchups"
  add_foreign_key "punting_stats", "nfl_players"
  add_foreign_key "punting_stats", "nfl_teams"
  add_foreign_key "receiving_stats", "nfl_matchups"
  add_foreign_key "receiving_stats", "nfl_players"
  add_foreign_key "receiving_stats", "nfl_teams"
  add_foreign_key "return_stats", "nfl_matchups"
  add_foreign_key "return_stats", "nfl_players"
  add_foreign_key "return_stats", "nfl_teams"
  add_foreign_key "rushing_stats", "nfl_matchups"
  add_foreign_key "rushing_stats", "nfl_players"
  add_foreign_key "rushing_stats", "nfl_teams"
end
