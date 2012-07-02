class PagesController < ApplicationController

  def index
    @location = "splash"
    redirect_to profile_path(current_user.slug) and return if current_user
    @user_detail = UserDetail.new
  end
end
