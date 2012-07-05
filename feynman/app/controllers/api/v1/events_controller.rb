class Api::V1::EventsController < ApiController
  before_filter :authenticate, :only => [:create, :index, :update]

  def index
    if params[:user_id]
      @events = Event.created_by(params[:user_id]).active
    else
      @events = Event.filter_by(current_user, params).active
    end
  end

  def create
    if current_user.events.create(params["event"])
      render :json => true, :status => :created
    else
      render :json => false, :status => :not_created
    end
  end

  def update
    event = current_user.events.find_by_id(params["id"])
    if event.set_to_inactive
      render :json => true, :status => :created
    else
      render :json => false, :status => :not_created
    end
  end
end