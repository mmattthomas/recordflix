class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :sign_up_params, only: [:create]
  # skip_before_action :verify_authenticity_token, :only => :create

  def new
    @user = User.new
    if (invite_code = params['invite_code']).present?
      #puts "into it! with #{invite_code}"      
      @user.invite_code = invite_code
    end
    
    @resource = @user
    @resource_name = "User"
  
  end

  def create

    invite_code = params[:user][:invite_code]
    invite_code.upcase!
    if !invite_code.empty?
      team = Team.where("invite_code = '#{invite_code}'").first
    else
      team_name = params[:user][:team_name]
    end

    super do |resource|
      if resource.errors.empty?
        handle_team(resource, team, team_name)
        set_flash_message :notice, :signed_up, :username => resource.name, :teamname => resource.team_name if is_flashing_format?
      end
    end
    
  end

  def edit
    resource.team_name = resource.team.name
    resource.team_short_name = resource.team.short_name
    resource.team_checkout_limit = resource.team.checkout_limit
    super
  end

  def update

    super do |resource|

      if resource.admin
        team = Team.find(resource.team.id)
        team.name = resource.team_name
        team.short_name = resource.team_short_name
        team.checkout_limit = resource.team_checkout_limit
        team.save!
      end
    end

    
  end
  
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :team_name, :email, :password, :password_confirmation, :phone_number, :invite_code])
  end

  private
  
  def get_team_from_invite(invite_code)
    # check if invite code exists + matches team (no? error)
    # or if not exist, checkif team name already exists (yes? error)
    # if team name doesnt exist, return true to allow completion of signup

    if !invite_code.empty?
      puts "has invite code of #{invite_code}"
      team = Team.where("invite_code = #{invite_code}").first
      puts "found team: #{team.name}"
      return team
    end

  end

  def handle_team(new_user, team, new_team_name)
    # check if team name exists - if yes, then join, if not, then create
    #team = Team.find_by name: new_user.team_name
    if team.nil?
      if !new_team_name.empty?
        #not found, create
        new_team = Team.new
        #new_team.name = new_user.team_name
        new_team.name = new_team_name
        #new_team.checkout_limit = 3
        new_team.invite_code = (0...8).map { (65 + rand(26)).chr }.join
        new_team.short_name = "#{new_team.name.slice(0..2)} Tracks"
        new_team.save!

        new_user.team_id = new_team.id
        new_user.admin = true
        new_user.save!
        puts "Created new team: #{new_user.team_name}"
        Rails.logger.debug "Created new team: #{new_user.team_name}"
      end
      # else do nothing, no team, no team name found
    else
      #found - set team id
      new_user.team_id = team.id
      new_user.save!
      puts "Joined team: #{new_user.team_name}"
      Rails.logger.debug "Joined team: #{new_user.team_name}"
    end
  end

  def sign_up_params
    params.require(:user).permit(:name, :team, :team_name, :email, :password, :password_confirmation,:phone_number, :avatar_url, :invite_code)
  end

  def account_update_params
    #... maybe don't permit team?
    params.require(:user).permit(:name, :team, :team_name, :team_short_name, :team_checkout_limit, :email, :password, :password_confirmation, :current_password, :phone_number, :avatar_url, :avatar)
  end

  def configure_permitted_parameters
    puts ">>>>>.>>>>>INTO CONFIGURE PERMITTED PARAMETERES"
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :team_name, :invite_code, :phone_number, :avatar_url])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar, :phone_number, :avatar_url])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar, :phone_number, :avatar_url])
  end

end