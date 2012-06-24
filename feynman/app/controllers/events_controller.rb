class EventsController < ApplicationController
  def create
    # Event.create_with_gem(current_user.authentication_token, params["event"])
    client.create_event(params)

    redirect_to profile_path(current_user)
  end

  def index
    @events = JSON.parse(client.get_events[:response])
    raise @events.inspect
  end
end