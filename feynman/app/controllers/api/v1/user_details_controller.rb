class Api::V1::UserDetailsController < ApiController
  before_filter :authenticate, :only => [:update]

  def update
    if current_user.user_detail.update_attributes({params[:id] => params[:value]})
      render :json => params[:value]
    else
      render :json => "You are not authorized to do that."
    end
  end
end
