class AddUserRefToForumTopic < ActiveRecord::Migration
  def change
    add_reference :forum_topics, :user, index: true
  end
end
