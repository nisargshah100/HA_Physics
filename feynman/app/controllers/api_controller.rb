class ApiController < ActionController::Base
  attr_accessor :current_user

  private

  def authenticate
    @current_user = User.find_by_authentication_token(params[:authentication_token])
    unless @current_user
      render :json => "User cannot be authenticated.", :status => :unauthorized
    end
  end

end
