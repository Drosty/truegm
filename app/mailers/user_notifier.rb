class UserNotifier < ActionMailer::Base
  default :from => 'admin@truegm.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_invite_email(invite)
    @invite = invite
    mail(:to => @invite.email, :subject => "You've been invited to a TrueGM League")
  end

  def existing_user_invite(invite)
    @invite = invite
    mail(:to => @invite.email, :subject => "You have been added to a TrueGM League")
  end

end
