class LikesController < ApplicationController

  before_action :find_track

  def create
    @track.track_likes.create(user_id: current_user.id)
    redirect_to tracks_path
    # eh, maybe no redirect  
  end

  def destroy
    logger.info "Track id: #{@track.id}"
    logger.info "tracklikeid: #{params[:id]}"
    @like = TrackLike.where(user_id: current_user.id).where(track_id: @track.id).first
    @like.destroy
    redirect_to tracks_path
  end

  private

  def find_track
    @track = Track.find(params[:track_id])
  end
end
