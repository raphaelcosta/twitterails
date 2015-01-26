class UsersController < ApplicationController
  before_filter :authorize
  before_filter :load_user, except: :index
  before_filter :check_if_is_blocked, only: :show

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

  def block
    if current_user.block(@user)
      redirect_to users_path, notice: "You blocked #{@user.username}"
    else
      redirect_to users_path, notice: "You can't block #{@user.username}"
    end
  end

  def unblock
    if current_user.unblock(@user)
      redirect_to users_path, notice: "You unblocked #{@user.username}"
    else
      redirect_to users_path, notice: "You don't blocked #{@user.username}"
    end
  end

  private

  def load_user
    @user = User.find_by!(username: params[:id])
  end

  def check_if_is_blocked
    if @user.blocked? current_user
      redirect_to root_path, alert: 'This user is not avaliable'
    end
  end
end
