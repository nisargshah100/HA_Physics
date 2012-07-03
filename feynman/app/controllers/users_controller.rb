class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find_by_slug(params[:slug])
    @events = @user.events
    @message = Message.new
    @location = "user_profile"

    @is_owner = true if @user == current_user

    if @user.nil?
      redirect_to events_path, :notice => "That user was not found."
    end
  end

end