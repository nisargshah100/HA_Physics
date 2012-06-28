class SignupsController < ApplicationController

  def preferences
    @user_detail = UserDetail.new()
  end
  
  def save_preferences
    if UserDetail.new(params[:user_detail]).valid?
      @user_preferences = params[:user_detail].to_json
      @user = User.new
      render 'personal_details'
    else
      render 'preferences'
    end
  end

  def create
    user_preferences = JSON.parse(params[:user].delete(:user_preferences))
    @user = User.new(params[:user])
    if @user.valid?
      @user.save
      @user.create_user_detail(user_preferences)
      sign_in(:user, @user)
      redirect_to profile_path(@user.display_name), :notice => "You have successfully signed up."
    else
      @user_preferences = user_preferences.to_json
      render 'personal_details'
    end
  end
end
