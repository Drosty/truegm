class NewForumTopicWorker
  include Sidekiq::Worker

  def perform(topic_id)
    topic = ForumTopic.find_by(id: topic_id)
    league = topic.league

    emails = []
    teams = league.teams
    teams.each do |t|
      unless t.user.nil?
        emails << t.user.email if t.user.email.include?("@")
      end
    end
    
    emails.each do |email|
      ForumNotifier.send_new_topic_email(email, topic).deliver
    end

  end

end
