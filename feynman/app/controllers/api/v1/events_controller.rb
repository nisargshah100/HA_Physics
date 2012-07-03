class Api::V1::EventsController < ApiController
  before_filter :authenticate, :only => [:create, :index]

  def index
    if params[:user_id]
      @events = Event.created_by(params[:user_id])
    else
      @events = Event.filter_by(current_user, params)
    end
    
    render :json => false, :status => :not_found unless @events
  end

  def create
    if current_user.events.create(params["event"])
      render :json => true, :status => :created
    else
      render :json => false, :status => :not_created
    end
  end
end