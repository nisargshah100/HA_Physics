class Api::V1::UserDetailsController < ApiController
  before_filter :authenticate, :only => [:update]

  def update
    params[:user_detail] ||= { params[:attribute] => params[:value] }
    if current_user.user_detail.update_attributes(params[:user_detail])
      render :json => params[:value] #for jeditable to display
    end
  end
end
