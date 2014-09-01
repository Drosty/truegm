require 'logger'

class ForumNotifier < ActionMailer::Base
  default :from => 'admin@truegm.com'

  def send_new_topic_email(email, topic)
    @topic = topic
    set_urls @topic

    log_email_sent("Forum Topic", email)
    mail(:to => email, :subject => "New Forum Topic - #{@topic.name}")
  end

  def send_new_forum_post_email(email, topic)
    @topic = topic
    set_urls @topic

    log_email_sent("Forum Post", email)
    mail(:to => email, :subject => "New Post in Topic = #{@topic.name}")
  end

  def set_urls topic
    host = ActionMailer::Base.default_url_options[:host]
    @topic_url = "#{host}/#/league/#{topic.league.id}/topics/#{topic.id}"
    @league_url = "#{host}/#/league/#{topic.league.id}"
    @leagues_url = "#{host}/#/leagues"
  end

  def log_email_sent type, email_address
    log = Logger.new('log/email.log')
    log.debug "#{type} - #{email_address}"
  end

end
