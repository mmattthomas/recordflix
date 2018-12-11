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
    parseErr = ""
    parser = @track.url
    urls = parser.scan(/(https?:\/\/([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)/)
    @track.url = nil
    if urls.length > 0
      if urls[0].length > 0
        @track.url = urls[0][0]
        begin
          resource = OEmbed::Providers.get(@track.url)
        rescue OEmbed::NotFound
          parseErr = "Sorry, I currently am not able to undertand/translate that link.  Hopefully I will in the future!"
        rescue Exception
          parseErr = "Error, I encountered an error handling this link"
        end
        if parseErr.empty? && !resource.title.empty?
          @track.embed_html = resource.html.html_safe
          @track.thumbnail =resource.thumbnail_url
          if @track.title.empty?
            @track.title = resource.title
          end
        end
      end
    end

    respond_to do |format|
      if !parseErr.empty?
        format.html { redirect_to tracks_url, alert: parseErr }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      else 
        if @track.save
          format.html { redirect_to tracks_url, notice: 'Your track was successfully added!' }
          format.json { render :show, status: :created, location: @track }
        else
          format.html { redirect_to tracks_url, alert: "Sorry, I'm unable to understand that link" }
          format.json { render json: @track.errors, status: :unprocessable_entity }
        end
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

  #like/dislike
  def like
    @track = Track.find(params[:id])
    @track.liked_by current_user
  
    puts ">>>.>>> ENTERED LIKE >>> "

    if request.xhr?
      #head :ok
      #return count of likes for efficiency of ajax request
      puts ">>>.>>> ENTERED LIKE SUCCESS - LIKE COUNT IS:  #{@track.get_likes.size} >>> "
      render json: { count: @track.get_likes.size, id: params[:id] }
    else
      redirect_to @track
    end
  end

  def unlike
    @track = Track.find(params[:id])
    @track.unliked_by current_user

    puts ">>>.>>> ENTERED UNLIKE >>> "
  
    if request.xhr?
      #head :ok
      #return count of likes for efficiency of ajax request
      puts ">>>.>>> ENTERED UNLIKE SUCCESS - LIKE COUNT IS:  #{@track.get_likes.size} >>> "
      render json: { count: @track.get_likes.size, id: params[:id] }
    else
      redirect_to @track
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
