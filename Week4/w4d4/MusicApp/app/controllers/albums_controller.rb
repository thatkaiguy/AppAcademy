class AlbumsController < ApplicationController

  before_action :redirect_unless_signed_in

  def redirect_unless_signed_in
    unless current_user
      redirect_to new_session_url
    end
  end
  
  def new
    @album = Album.new(band_id: params[:band_id])
    render :new
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to albums_url(@album)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @band = @album.band
    @album.destroy!
    redirect_to bands_url(@band)
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :title, :recording_location)
  end
end
