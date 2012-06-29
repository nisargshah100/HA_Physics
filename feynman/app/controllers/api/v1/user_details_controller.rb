class Api::V1::UserDetailsController < ApiController
  before_filter :authenticate, :only => [:update]

  def update
    if params[:user_detail]
      attribute_hash = params[:user_detail]
    else
      attribute_hash = { params[:id] => params[:value] }
    end

    if current_user.user_detail.update_attributes(attribute_hash)
      render :json => params[:value]
    else
      render :json => "You are not authorized to do that."
    end
  end
end
