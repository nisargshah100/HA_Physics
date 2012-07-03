class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @message = current_user.messages.find_by_id(params[:id])
    if @message
      @messages = current_user.messages_with(@message.sender).order("created_at DESC")
      @messages.each{ |message| message.mark_as_opened }
    else
      redirect_to profile_path, :notice => "You are not authorized to view this message."
    end
  end
end