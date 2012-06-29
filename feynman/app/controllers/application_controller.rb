class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_message_count

  private

  def after_sign_in_path_for(resource)
    unless (current_user.user_detail && current_user.complete?)
      new_signup_path
    end
  end

  def client
    Feynman::Client.new({:token => current_user.authentication_token})
  end

  def get_message_count
    @message_count = current_user.messages.size if current_user
  end
end