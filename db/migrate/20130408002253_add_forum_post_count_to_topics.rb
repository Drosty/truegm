class AddForumPostCountToTopics < ActiveRecord::Migration
  def up
    add_column :forum_topics, :forumposts_count, :integer, :default => 0

    ForumTopic.reset_column_information
    ForumTopic.find(:all).each do |t|
      ForumTopic.update_counters t.id, :forumposts_count => t.forum_posts.length
    end
  end

  def down
    remove_column :forum_topics, :forumposts_count
  end
end
