class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def instagram
    @data = request.env["omniauth.auth"]
    response = Authentication.create_instagram(current_user, @data)
    flash[:notice] = "Instagram account successfully added."
    redirect_to profile_path(current_user.slug)
  end

end