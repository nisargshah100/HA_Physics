class Api::V1::MessagesController < ApiController
  before_filter :authenticate

  def index
    @messages = current_user.messages

    unless @messages
      render :json => false, :status => :not_found
    end
  end
end
