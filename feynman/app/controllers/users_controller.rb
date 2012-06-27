class UsersController < ApplicationController
  # before_filter :authenticate_user!

  def show
    @user = User.find_by_display_name(params[:display_name])
    @event = Event.new

    if @user == current_user
      @my_events = @user.events
      render 'show_my_profile'
    end

    if @user.nil?
      redirect_to events_path, :notice => "That user was not found."
    end
  end

end