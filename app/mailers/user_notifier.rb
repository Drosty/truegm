class UserNotifier < ActionMailer::Base
  default :from => 'admin@truegm.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_invite_email(invite)
    @invite = invite
    log_email_sent("send invite", @invite.email)
    mail(:to => @invite.email, :subject => "You've been invited to a TrueGM League")
  end

  def existing_user_invite(invite)
    @invite = invite
    log_email_sent("existing user invite", @invite.email)
    mail(:to => @invite.email, :subject => "You have been added to a TrueGM League")
  end

  def log_email_sent type, email_address
    log = Logger.new('log/email.log')
    log.debug "#{type} - #{email_address}"
  end

end
