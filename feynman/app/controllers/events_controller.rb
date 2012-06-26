class EventsController < ApplicationController
  def create
    if current_user.events.create(params["event"])
      redirect_to profile_path(current_user)
    else
      render :json => false, :status => :not_created
    end
  end

  def index
    # @events = JSON.parse(client.get_events[:response])
    # raise @events.inspect
  end
end