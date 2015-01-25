class SessionsController < ApplicationController
  layout 'login'

  def create
    user = User.find_by(username: user_params[:username])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'You have been successfully logged in'
    else
      redirect_to login_path, alert: 'Invalid username or password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'You have logged out successfully'
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
