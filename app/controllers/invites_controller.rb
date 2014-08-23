class InvitesController < ApplicationController

  def create
    @invite = Invite.new(invite_params) # Make a new Invite
    team = Team.find(invite_params[:team_id])
    @invite.sender_id = current_user.id # set the sender to the current user

    respond_to do |format|
      if @invite.save
        #if the user already exists
        if @invite.recipient != nil
          #Add the user to the team
          @invite.recipient.teams << @invite.team

          #send a notification email
          UserNotifier.existing_user_invite(@invite).deliver
          format.html { redirect_to edit_admin_team_path(team), notice: "User has been added to league.  An email has been sent to #{@invite.email}." }
        else
          UserNotifier.send_invite_email(@invite).deliver
          format.html { redirect_to edit_admin_team_path(team), notice: "Invite sent to #{@invite.email}." }
        end
      else
        # oh no, creating an new invitation failed
      end
    end
  end

  def invite_params
    params.require(:invite).permit(:team_id, :email)
  end

end
