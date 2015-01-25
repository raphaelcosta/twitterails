class AccountsController < ApplicationController
  before_filter :authorize
  before_filter :load_user

  def update
    if @user.update_attributes(user_params)
      redirect_to account_path, notice: 'Your account have been successfully updated.'
    else
      render :edit
    end
  end

  private

  def load_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :password)
  end
end
