class UserDetailsController < ApplicationController

  def update
    user_detail = UserDetail.find_by_id(params[:id])
    if current_user == user_detail.user && user_detail.update_attributes(params[:user_detail])
      redirect_to profile_path(user_detail.slug), :notice => "Updated."
    else
      redirect_to profile_path(user_detail.slug), :notice => "You are not authorized to do that."
    end
  end

end
