class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    if current_user.events.create(params["event"])
      redirect_to profile_path(current_user)
    else
      render :json => false, :status => :not_created
    end
  end

  def index
  end
end