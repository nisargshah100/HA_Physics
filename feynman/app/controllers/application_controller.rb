class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def client
    Feynman::Client.new({:token => current_user.authentication_token})
  end
end
