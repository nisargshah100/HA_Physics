class SignupsController < ApplicationController
  def create
    user_preferences = JSON.parse(params[:user].delete(:user_preferences))
    @user = User.new(params[:user])

    if @user.valid?
      @user = User.create_user_with_detail(params[:user], user_preferences)
      sign_in(:user, @user)
      redirect_to profile_path(@user.slug), :notice => "You have successfully signed up."
    else
      @user_preferences = user_preferences.to_json
      render 'personal_details'
    end
  end
end
