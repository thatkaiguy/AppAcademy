class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(*user_params.values)
    if @user
      log_in_user!(@user)
      redirect_to bands_url
    else
      @user = User.new(user_params.except(:password))
      render :new
    end
  end

  def destroy
    @user = current_user
    log_out_user!(@user) if @user
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).slice(:email, :password)
  end

end
