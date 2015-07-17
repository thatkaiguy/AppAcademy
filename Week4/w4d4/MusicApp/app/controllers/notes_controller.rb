class NotesController < ApplicationController
  before_action :can_destroy, only: [:destroy]

  def can_destroy
    @note = Note.find(params[:id])
    render text: "403 FORBIDDEN" if current_user.email != @note.user.email
  end

  def create
    @note = Note.new(note_params.merge(track_id: params[:track_id], user_id: current_user.id))
    @note.save
    redirect_to track_url(params[:track_id])
  end

  def destroy
    @note = Note.find(params[:id])
    @track = @note.track
    @note.destroy
    redirect_to track_url(@track.id)
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end
end
