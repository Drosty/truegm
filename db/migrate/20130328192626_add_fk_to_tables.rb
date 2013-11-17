class AddFkToTables < ActiveRecord::Migration
  def up
    add_index "draft_picks", ["original_team_id"], :name => "draft_pick_original_team_fk"
    add_index "draft_picks", ["team_id"], :name => "draft_pick_current_team_fk"

    add_index "external_links", ["user_id"], :name => "link_url_fk"

    add_index "forum_posts", ["user_id"], :name => "forum_post_user_fk"
    add_index "forum_posts", ["forum_topic_id"], :name => "forum_post_forum_topic_fk"

    add_index "forum_topics", ["league_id"], :name => "forum_topic_league_fk"

    add_index "matchups", ["home_team_id"], :name => "matchup_home_team_fk"
    add_index "matchups", ["away_team_id"], :name => "matchup_away_team_fk"

    add_index "nfl_players", ["nfl_team_id"], :name => "nfl_player_nfl_team_id"

    add_index "power_rankings", ["team_id"], :name => "power_ranking_team_fk"

    add_index "teams", ["league_id"], :name => "team_league_fk"
    add_index "teams", ["user_id"], :name => "team_user_fk"

    add_index "trades", ["from_team_id"], :name => "trade_from_team_fk"
    add_index "trades", ["to_team_id"], :name => "trade_to_team_fk"

    add_index "trade_items", ["trade_id"], :name => "trade_item_trade_fk"

    add_index "trade_votes", ["trade_id"], :name => "trade_vote_trade_fk"
    add_index "trade_votes", ["team_id"], :name => "trade_vote_user_fk"
  end

  def down
    remove_index "draft_picks", :name => "draft_pick_original_team_fk"
    remove_index "draft_picks", :name => "draft_pick_current_team_fk"

    remove_index "external_links", :name => "link_url_fk"

    remove_index "forum_posts", :name => "forum_post_user_fk"
    remove_index "forum_posts", :name => "forum_post_forum_topic_fk"

    remove_index "forum_topics", :name => "forum_topic_league_fk"

    remove_index "matchups", :name => "matchup_home_team_fk"
    remove_index "matchups", :name => "matchup_away_team_fk"

    remove_index "nfl_players", :name => "nfl_player_nfl_team_id"

    remove_index "power_rankings", :name => "power_ranking_team_fk"

    remove_index "teams", :name => "team_league_fk"
    remove_index "teams", :name => "team_user_fk"

    remove_index "trades", :name => "trade_from_team_fk"
    remove_index "trades", :name => "trade_to_team_fk"

    remove_index "trade_items", :name => "trade_item_trade_fk"

    remove_index "trade_votes", :name => "trade_vote_trade_fk"
    remove_index "trade_votes", :name => "trade_vote_user_fk"
  end
end
