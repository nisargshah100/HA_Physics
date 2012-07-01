class Api::V1::EventsController < ApiController
  before_filter :authenticate, :only => [:create]

  def index
    @events = params[:user_id] ? Event.for_user(params[:user_id]) : Event.all
    unless @events
      render :json => false, :status => :not_found
    end
  end

  def create
    if current_user.events.create(params["event"])
      render :json => true, :status => :created
    else
      render :json => false, :status => :not_created
    end
  end
end