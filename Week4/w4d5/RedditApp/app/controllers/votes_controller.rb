class VotesController < ApplicationController
  def upvote
    @vote = Vote.new(vote_params)
    @vote.value = 1
    if @vote.save
      redirect_to sub_url(params[:sub_id])
    else
      flash.now[:errors] = @vote.errors.full_messages
      redirect_to sub_url(params[:sub_id])
    end
  end

  def downvote
    @vote = Vote.new(vote_params)
    @vote.value = -1
    if @vote.save
      redirect_to sub_url(params[:sub_id])
    else
      flash.now[:errors] = @vote.errors.full_messages
      redirect_to sub_url(params[:sub_id])
    end
  end

  private

  def vote_params
    params.permit(:voteable_id, :voteable_type)
  end
end
