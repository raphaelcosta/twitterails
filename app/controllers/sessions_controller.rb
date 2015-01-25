class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(user_params[:username])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'You have been successfully logged in'
    else
      redirect_to login_path, alert: 'Invalid username or password'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
