class UserNotifier < ActionMailer::Base
  default :from => 'ryandrost@truegm.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_invite_email(invite, invite_path)
    @invite = invite
    @invite_path = invite_path
    mail(:to => @invite.email, :subject => "You've been invited to a TrueGM League")
  end
end
