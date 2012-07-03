class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @message = current_user.messages.find_by_id(params[:id])
    if @message
      @message.mark_as_opened
      @messages = current_user.all_messages.where{ 
                    (sender_id.eq my{ @message.sender_id }) & (recipient_id.eq my{ current_user.id }) | 
                    (recipient_id.eq my{ @message.sender_id }) & (sender_id.eq my{ current_user.id })
                  }.order("created_at DESC")
    else
      redirect_to profile_path, :notice => "You are not authorized to view this message."
    end
  end
end