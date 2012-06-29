class Api::V1::MessagesController < ApiController
  before_filter :authenticate
  
  def create
    params[:message].merge!({:sender => current_user})
    @message = Message.create(params[:message])
    render json: @message
  end

  def index
    @messages = current_user.messages

    unless @messages
      render :json => false, :status => :not_found
    end
  end
end
