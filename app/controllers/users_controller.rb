class UsersController < ApplicationController
  before_filter :authorize
  before_filter :load_user, only: [:show, :follow, :unfollow]

  def index
    @users = User.excluding_user(current_user).page params[:page]
  end

  def show
    @messages = @user.messages.page params[:page]
  end

  def follow
    if current_user.follow(@user)
      redirect_to users_path, notice: "Now you are following #{@user.username}"
    else
      redirect_to users_path, notice: "You can't follow #{@user.username}"
    end
  end

  def unfollow
    if current_user.unfollow(@user)
      redirect_to users_path, notice: "You unfollowed #{@user.username}"
    else
      redirect_to users_path, notice: "You don't follow #{@user.username}"
    end
  end


  private

  def load_user
    @user = User.find_by!(username: params[:id])
  end
end
