class CommentsController < ApplicationController
  def index
    render json: find_commentable.comments
  end

  def create
    @commentable = find_commentable
    @comment = Comment.new(
      comment_params.merge(
        commentable_id: @commentable.id,
        commentable_type: @commentable.class.to_s
      )
    )
    if @comment.save
      render json: @comment
    else
      render(
        json: @comment.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render json: @comment
    else
      render(
        json: @comment.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render json: @comment
    else
      render(
        json: ["You don't have permission to destroy that"]
      )
    end
  end

  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
