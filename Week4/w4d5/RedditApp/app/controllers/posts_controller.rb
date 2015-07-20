class PostsController < ApplicationController
  before_action :redirect_if_not_author, only: [:edit, :update]

  def redirect_if_not_author
    @post = Post.find(params[:id])
    redirect_to post_url(@post) if current_user.id != @post.author_id
  end

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params.merge({author_id: current_user.id}))
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @subs = Sub.all
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @subs = Sub.all
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @parent_comments = @post.comments.includes(:author).where(parent_comment_id: nil)
    @child_comments = @post.comments_by_parent_id
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @sub = @post.sub
    @post.destroy!
    redirect_to sub_url(@sub)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end
