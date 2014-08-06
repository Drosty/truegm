class UserNotifier < ActionMailer::Base
  default :from => 'ryandrost@truegm.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_invite_email(user)
    @user = user
    mail(:to => @user.email, :subject => "You've been invited to a TrueGM League")
  end
end
