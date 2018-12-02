class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /tracks
  # GET /tracks.json
  def index
    @current_user = current_user
    @tracks = Track.sorted

    # for quick-post at the top:
    @track = Track.new
    @track.posted_by_id = current_user.id
    @track.team_id = current_user.team_id
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
  end

  # GET /tracks/new
  def new
    @track = Track.new
    @track.posted_by_id = current_user.id
    @track.team_id = current_user.team_id
    @available_users = User.for_team_id(current_user.team_id)
  end

  # GET /tracks/1/edit
  def edit
    @available_users = User.for_team_id(current_user.team_id)

  end

  # POST /tracks
  # POST /tracks.json
  def create
    @track = Track.new(track_params)

    @track.posted_by_id = current_user.id
    @track.team_id = current_user.team_id

    resource = OEmbed::Providers.get(@track.url)
    if !resource.title.empty?
      @track.embed_html = resource.html.html_safe
      @track.thumbnail =resource.thumbnail_url
      if @track.title.empty?
        @track.title = resource.title
      end
    end
    # if @track.url.include? ".youtube."
    #   @youtube = OEmbed::Providers::Youtube.get(@track.url)
    #   @track.embed_html = @youtube.html.html_safe
    #   @track.thumbnail =@youtube.thumbnail_url
    #   if @track.title.empty?
    #     @track.title = @youtube.title
    #   end
    # end
    # if @track.url.include? ".soundcloud."
    #   @soudncloud = OEmbed::Providers::Soundcloud.get(@track.url)
    #   @track.embed_html = @soudncloud.html.html_safe
    #   @track.thumbnail =@soudncloud.thumbnail_url
    #   if @track.title.empty?
    #     @track.title = @soudncloud.title
    #   end
    # end    
    # if @track.url.include? ".spotify."
    #   @spotify = OEmbed::Providers::Spotify.get(@track.url)
    #   @track.embed_html = @spotify.html.html_safe
    #   @track.thumbnail =@spotify.thumbnail_url
    #   if @track.title.empty?
    #     @track.title = @spotify.title
    #   end
    # end

    respond_to do |format|
      if @track.save
        format.html { redirect_to tracks_url, notice: 'Your track was successfully added!' }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { render :new }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to tracks_url, notice: 'Track was successfully updated!' }
        format.json { render :show, status: :ok, location: @track }
      else
        format.html { render :edit }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @track.destroy
    respond_to do |format|
      format.html { redirect_to tracks_url, notice: 'Track was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params.require(:track).permit(:title, :description, :likes, :comments, :url, :posted_by_id, :team_id)
    end
end
