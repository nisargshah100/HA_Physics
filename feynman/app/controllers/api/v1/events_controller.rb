class Api::V1::EventsController < ApiController
  def index
    @events = params[:user_id] ? Event.for_user(params[:user_id]) : Event.all
    unless @events
      render :json => false, :status => :not_found
    end
  end
end