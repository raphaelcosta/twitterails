class DashboardController < ApplicationController
  before_filter :authorize

  def index
    @user = current_user
    @message = @user.messages.build
    @messages = @user.messages.page params[:page]
  end
end
