class GroupsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups
    render json: @groups
  end

  def show
    @group = Group.find(params[:id])
    render json: @group
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      render json: @group
    else
      render(
        json: @group.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      render json: @group
    else
      render(
        json: @group.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      render json: @group
    else
      render(
        json: @group.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  private
  def group_params
    params[:group].permit(:user_id, :group_name)
  end
end
