class UsersController < ApplicationController
  def show    
    @user = User.find(params[:id])
    # @graph = Koala::Facebook::API.new(@user.oauth_access_token)
    @event = Event.new
    # pictures = @graph.get_connections("me", "photos")
    # profile = @graph.get_object("1111218")
    # raise profile.inspect
  end
end
