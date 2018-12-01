class RegistrationsController < Devise::RegistrationsController

  def new
    
    #super
    puts "working?"
    @user = User.new
    if (signup_team = params['signup_team']).present?
      puts "into it! with #{signup_team}"      
      @user.team_name = signup_team
    end
    @resource = @user
    @resource_name = "User"
    # @user = User.new
    # @user.team_name = "Enter Team Name To Join or Create Here"
    # @resource = @user
    # @resource_name = "User"
  end

  def create
    super do |resource|
      handle_team(resource)
      set_flash_message :notice, :signed_up, :username => resource.name, :teamname => resource.team_name if is_flashing_format?
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

  private

  def handle_team(new_user)
    # check if team name exists - if yes, then join, if not, then create
    team = Team.find_by name: new_user.team_name
    if team.nil?
      #not found, create
      new_team = Team.new
      new_team.name = new_user.team_name
      new_team.checkout_limit = 3
      new_team.short_name = new_team.name.slice(0..2)
      new_team.save!

      new_user.team_id = new_team.id
      new_user.admin = true
      new_user.save!
      puts "Created new team: #{new_user.team_name}"
      Rails.logger.debug "Created new team: #{new_user.team_name}"
    else
      #found - set team id
      new_user.team_id = team.id
      new_user.save!
      puts "Joined team: #{new_user.team_name}"
      Rails.logger.debug "Joined team: #{new_user.team_name}"
    end
  end

  def sign_up_params
    params.require(:user).permit(:name, :team, :team_name, :email, :password, :password_confirmation,:phone_number, :avatar_url)
  end

  def account_update_params
    #... maybe don't permit team?
    params.require(:user).permit(:name, :team, :team_name, :team_short_name, :team_checkout_limit, :email, :password, :password_confirmation, :current_password, :phone_number, :avatar_url)
  end
end