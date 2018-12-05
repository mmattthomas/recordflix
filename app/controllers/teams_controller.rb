class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
    @team.invite_code = (0...8).map { (65 + rand(26)).chr }.join
    @invite_link = "https://recordpool.herokuapp.com/users/sign_up?invite_code=#{@team.invite_code}"
  end

  # GET /teams/1/edit
  def edit
    puts "The team name is : #{@team.name}"
    puts "The team invite is : #{@team.invite_code}"
    if @team.invite_code.nil?
      @team.invite_code = (0...8).map { (65 + rand(26)).chr }.join
    end
    @invite_link = "https://recordpool.herokuapp.com/users/sign_up?invite_code=#{@team.invite_code}"
  end

  # POST /teams
  # POST /teams.json
  def create

    if (current_user.email = "citytank@gmail.com")

      @team = Team.new(team_params)

      respond_to do |format|
        if @team.save
          # team shouldn't be creatable through this way
          format.html { redirect_to tracks_url, notice: 'Team was successfully created.' }
          #format.html { redirect_to @team, notice: 'Team was successfully created.' }
          format.json { render :show, status: :created, location: @team }
        else
          format.html { render :new }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    else
      format.html { redirect_to tracks_url, notice: 'You do not have the ability to create a team' }
      format.json { render json: @team.errors, status: :unprocessable_entity }
    end 
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if (current_user.team_id != @team.id) 
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      else
        if @team.update(team_params)
          #format.html { redirect_to @team, notice: 'Team was successfully updated.' }
          #format.html { render :edit, notice: 'Team was successfully updated.' }
          format.html { redirect_to tracks_url, notice: 'Team was successfully updated.' }
          format.json { render :show, status: :ok, location: @team }
        else
          format.html { render :edit }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    if (current_user.team_id != @team.id || !current_user.admin?)
      return
    end 
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :short_name, :invite_code)
    end
end
