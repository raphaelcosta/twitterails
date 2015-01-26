class MessagesController < ApplicationController
  before_filter :authorize

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to root_path, notice: 'Your tweet have been published'
    else
      redirect_to root_path, alert: "Sorry, we are unable to post your tweet"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
