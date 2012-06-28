class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @message = Message.new
  end

  def index
  end

  def show
    @message = current_user.messages.find_by_id(params[:message_id])
    redirect_to message_path(@message.id) if @message.mark_as_opened
  end
end