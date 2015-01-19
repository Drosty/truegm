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

ActiveRecord::Schema.define(version: 20150119225735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
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

  create_table "draft_picks", force: true do |t|
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

  create_table "external_links", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "external_links", ["user_id"], name: "link_url_fk", using: :btree

  create_table "forum_posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "forum_topic_id"
    t.text     "post_body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_topics", force: true do |t|
    t.integer  "league_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forumposts_count", default: 0
    t.integer  "user_id"
  end

  create_table "invites", force: true do |t|
    t.string   "email"
    t.integer  "team_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", force: true do |t|
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
  end

  create_table "matchups", force: true do |t|
    t.integer  "year"
    t.integer  "week"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matchups", ["away_team_id"], name: "matchup_away_team_fk", using: :btree
  add_index "matchups", ["home_team_id"], name: "matchup_home_team_fk", using: :btree

  create_table "nfl_matchups", force: true do |t|
    t.integer  "import_game_id"
    t.integer  "week"
    t.integer  "year"
    t.datetime "game_date"
    t.integer  "away_team_id"
    t.integer  "home_team_id"
    t.string   "tv_station"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nfl_players", force: true do |t|
    t.integer  "nfl_team_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "position"
    t.integer  "salary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotrac_url"
    t.string   "full_name"
    t.integer  "nfl_data_id",     limit: 8
    t.string   "jersey"
    t.string   "height"
    t.string   "weight"
    t.datetime "dob"
    t.string   "college"
    t.boolean  "active"
    t.string   "fantasy_data_id"
  end

  add_index "nfl_players", ["nfl_data_id"], name: "index_nfl_players_on_nfl_data_id", unique: true, using: :btree
  add_index "nfl_players", ["nfl_team_id"], name: "nfl_player_nfl_team_id", using: :btree

  create_table "nfl_players_teams", id: false, force: true do |t|
    t.integer "team_id"
    t.integer "nfl_player_id"
  end

  add_index "nfl_players_teams", ["team_id", "nfl_player_id"], name: "by_team_and_player", unique: true, using: :btree

  create_table "nfl_teams", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotrac_url"
    t.string   "code"
    t.string   "full_name"
    t.string   "short_name"
    t.integer  "bye_week"
  end

  create_table "power_rankings", force: true do |t|
    t.integer  "team_id"
    t.text     "description"
    t.integer  "rank"
    t.integer  "week"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "power_rankings", ["team_id"], name: "power_ranking_team_fk", using: :btree

  create_table "stats", force: true do |t|
    t.integer "nfl_player_id"
    t.integer "passing_yards"
    t.integer "passing_touchdowns"
    t.integer "interceptions"
    t.integer "rushing_yards"
    t.integer "rushing_touchdowns"
    t.integer "receptions"
    t.integer "receiving_yards"
    t.integer "receiving_touchdowns"
    t.integer "fumbles_lost"
    t.integer "year"
    t.integer "week"
    t.integer "tfl"
    t.integer "sacks"
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
    t.float   "average_pass_yards"
    t.float   "qb_rating"
    t.integer "rushing_attempts"
    t.float   "rushing_average"
    t.integer "fumbles"
    t.integer "long_run"
    t.float   "receiving_average"
    t.integer "receiving_long"
  end

  add_index "stats", ["nfl_player_id"], name: "index_stats_on_nfl_player_id", using: :btree

  create_table "teams", force: true do |t|
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

  create_table "trade_items", force: true do |t|
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

  create_table "trade_votes", force: true do |t|
    t.integer  "trade_id"
    t.integer  "team_id"
    t.string   "vote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trade_votes", ["team_id"], name: "trade_vote_user_fk", using: :btree
  add_index "trade_votes", ["trade_id"], name: "trade_vote_trade_fk", using: :btree

  create_table "trades", force: true do |t|
    t.integer  "from_team_id"
    t.integer  "to_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trades", ["from_team_id"], name: "trade_from_team_fk", using: :btree
  add_index "trades", ["to_team_id"], name: "trade_to_team_fk", using: :btree

  create_table "users", force: true do |t|
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

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
