class DropForumTopicAndForumPost < ActiveRecord::Migration
  def up 
    drop_table :forum_posts
    drop_table :forum_topics
  end

  def down
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
  end

end
