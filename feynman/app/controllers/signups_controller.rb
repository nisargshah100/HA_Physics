class SignupsController < ApplicationController

  def new
    @user_detail = UserDetail.new(user_detail_params)
    @user_detail.current_step = session[:user_detail_step]
  end

  def create
    user_detail_params.deep_merge!(params[:user_detail]) if params[:user_detail]
    @user_detail = UserDetail.new(user_detail_params)
    @user_detail.current_step = session[:user_detail_step]

    if @user_detail.valid?
      go_to_previous?(params) ? @user_detail.previous_step : @user_detail.next_step
      session[:user_detail_step] = @user_detail.current_step
    end

    if @user_detail.last_step? && @user_detail.all_valid?
      user = User.create_user_with_detail(params[:user], user_detail_params)
      clear_session_variables
      redirect_to profile_path(user.display_name), :notice => "You have successfully signed up."
    else
      render "new"
    end
  end

  private

  def go_to_previous?(params)
    params[:back_button]
  end

  def user_detail_params
    session[:user_detail_params] ||= {}
  end

  def clear_session_variables
    session[:user_detail_step] = nil
    session[:user_detail_params] = nil
  end

end
