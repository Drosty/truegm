class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @token = params[:invite_token] #<-- pulls the value from the url query string
    build_resource({})
    respond_with self.resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?

    if resource_saved

      @token = params[:invite_token]
      if @token != nil
         invite = Invite.find_by_token(@token)
         unless invite.nil?
           resource.teams << invite.team
         end
      end

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

end
