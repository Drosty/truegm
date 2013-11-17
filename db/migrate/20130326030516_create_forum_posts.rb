class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.integer :user_id
      t.integer :forum_topic_id
      t.text :post_body

      t.timestamps
    end
  end
end
