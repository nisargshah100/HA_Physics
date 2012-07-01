class SignupsController < ApplicationController

  def preferences
    @user_detail = UserDetail.new()
  end
  
  def save_preferences
    @user_detail = UserDetail.new(params[:user_detail])
    if @user_detail.valid?
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

    if params[:back_button]
      @user_detail = UserDetail.new(user_preferences)
      render 'preferences'
    elsif @user.valid?
      @user = User.create_user_with_detail(params[:user], user_preferences)
      sign_in(:user, @user)
      redirect_to profile_path(@user.slug), :notice => "You have successfully signed up."
    else
      @user_preferences = user_preferences.to_json
      render 'personal_details'
    end
  end
end
