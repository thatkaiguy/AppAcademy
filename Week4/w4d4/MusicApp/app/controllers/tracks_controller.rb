class TracksController < ApplicationController

  before_action :redirect_unless_signed_in

  def redirect_unless_signed_in
    unless current_user
      redirect_to new_session_url
    end
  end

  def new
    @track = Track.new(album_id: params[:album_id])
    render :new
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @album = @track.album
    @track.destroy!
    redirect_to album_url(@album)
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :is_bonus, :name, :lyrics)
  end
end
