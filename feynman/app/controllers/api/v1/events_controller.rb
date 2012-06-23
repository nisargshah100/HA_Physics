class Api::V1::EventsController < ApiController
  before_filter :authenticate, :only => [:create]

  def create
    event = current_user.events.build(params["event"])
    if event.save!
      render :json => true, :status => :created and return
    end
    
    render :json => false, :status => :not_implemented
  end

  def index
    if events = Event.all
      render :json => events, :status => :ok
    else
      render :json => false, :status => :not_found
    end
  end
end
