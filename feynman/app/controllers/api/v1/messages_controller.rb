class Api::V1::MessagesController < ApiController
  before_filter :authenticate
  
  def create
    params[:message].merge!({:sender => current_user})
    @message = Message.create(params[:message])
    
    if @message
      render :json => @message, :status => :created
    else
      render :json => false, :status => :bad_request
    end
  end

  def index
    @messages = current_user.messages
    render :json => false, :status => :not_found unless @messages
  end
end
