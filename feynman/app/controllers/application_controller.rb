class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def after_sign_in_path_for(resource)
    redirect_to new_signup_path unless current_user.complete?
  end

  def client
    Feynman::Client.new({:token => current_user.authentication_token})
  end
end
