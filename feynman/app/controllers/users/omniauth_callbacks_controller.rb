class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in @user and redirect_to new_signup_path
    else
      redirect_to root_url, :notice => 'An error has occurred. Please contact edweng@gmail.com'
    end
  end
end