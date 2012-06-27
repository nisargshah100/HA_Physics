class SignupsController < ApplicationController

  def new
    session[:user_detail_params] ||= {}
    @user_detail = UserDetail.new(session[:user_detail_params])
    @user_detail.current_step = session[:user_detail_step]
  end

  def create
    session[:user_detail_params].deep_merge!(params[:user_detail]) if params[:user_detail]
    @user_detail = UserDetail.new(session[:user_detail_params])
    @user_detail.current_step = session[:user_detail_step]
    if @user_detail.valid?
      if params[:back_button]
        @user_detail.previous_step
      else
        @user_detail.next_step
      end
      session[:user_detail_step] = @user_detail.current_step
    end

    if @user_detail.last_step? && @user_detail.all_valid?
      current_user.user_detail.update_attributes(session[:user_detail_params])
      current_user.user_detail.set_complete
      session[:user_detail_step] = session[:user_detail_params] = nil
      redirect_to current_user, :notice => "Get started."
    else
      render "new"
    end
  end

end
