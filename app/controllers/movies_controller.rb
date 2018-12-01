class MoviesController < ApplicationController
  
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :checkout, :checkin]
  before_action :get_cart
  before_action :authenticate_user!

  # GET /movies
  # GET /movies.json
  def index
    @current_user = current_user
    #@movies = Movie.sorted
    @movies = current_user.team.movies.sorted
    if !@checkout_warning.nil? && !@checkout_warning.empty?
      flash[:warning] = @checkout_warning
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @current_user = current_user

    @comments = @movie.comments.all
    @comment = @movie.comments.build

    if !@movie.override_checkout.nil? && @movie.override_checkout != ""
      @movie_checkout_status = "Checked out to #{@movie.override_checkout}"
    else 

      if !@movie.checked_out_to_id.nil?
        if @movie.checked_out_to_id == current_user.id
          @movie_checkout_status = "You currently have this movie"
        else
          checked_out_to = User.find(@movie.checked_out_to_id).name
          @movie_checkout_status = "Checked out to #{checked_out_to}" 
        end
      else
        @movie_checkout_status = "Available!" 
      end
    end
  end

  # GET /movies/new
  def new
    @movie = Movie.new
    @checkout_users = User.for_team(current_user.team_id)
  end

  # GET /movies/1/edit
  def edit
    @checkout_users = User.for_team(current_user.team_id)  
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    #all new movies created under team of current person (who is an admin because they CAN create)
    @movie.team_id = current_user.team_id

    @current_checkout = 0
    if @movie.rating.nil?
      @movie.rating = 0
    end
    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        @checkout_users = User.for_team(current_user.team_id)  
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update

    if @movie.rating.nil?
      @movie.rating = 0
    end

    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        #dev pro-tip: if update fails, it will rerender form but not call 
        #             edit controller method, so be sure to supply
        #             any needed instance vars before re-rendering:
        @checkout_users = User.for_team(current_user.team_id)
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def checkout
    if @movie.update(:checked_out_to => current_user)
      redirect_to @movie, notice: 'Movie was successfully checked out to you!' 
    else
      redirect_to @movie, notice: 'Error unable to checkout movie' 
    end    
  end

  def checkin
    
    if @movie.update(:checked_out_to => nil)
      redirect_to @movie, notice: 'Movie was successfully returned!' 
    else
      redirect_to @movie, notice: 'Error unable to return movie' 
    end
    
  end
  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Get Current count
    def get_cart
      @checkout_count = Movie.checkout_count_for_user current_user
      @checkout_limit = current_user.team.checkout_limit || 3
      @checkout_status = "(#{@checkout_count} of #{@checkout_limit} movies checked out)"
      @checkout_warning = ""
      if @checkout_count == @checkout_limit
        @checkout_warning = "Warning: you cannot checkout any more movies"
      elsif @checkout_count > @checkout_limit
        @checkout_warning = "You have checked out more movies than allowed!"
      end
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :rating, :runtime, :released, :url, :checked_out_to_id, :override_checkout, :team_id)
    end
end
