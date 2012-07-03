class Api::V1::UserDetailsController < ApiController
  before_filter :authenticate, :only => [:update, :jeditable]

  def update
    if current_user.user_detail.update_attributes(params[:user_detail])
      render :json => current_user.user_detail
    end
  end

  def jeditable
    params[:user_detail] ||= { params[:attribute] => params[:value] }
    if current_user.user_detail.update_attributes(params[:user_detail])
      render :json => params[:value], :status => :created #for jeditable to display
    end
  end
end
