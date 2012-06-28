class UsersController < ApplicationController
  # before_filter :authenticate_user!

  def show
    @user = User.find_by_display_name(params[:display_name])
    @events = @user.events
    
    @is_owner = true if @user == current_user

    if @user.nil?
      redirect_to events_path, :notice => "That user was not found."
    end
  end

end