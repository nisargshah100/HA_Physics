class Api::V1::AuthenticationsController < ApiController
  before_filter :authenticate, :only => [:index]

  # def index
  #   if params[:provider]
  #     @authentications = current_user.authentications.where(provider: params[:provider])
  #   else
  #     @authentications = current_user.authentications 
  #   end

  #   if @authentications
  #     render :json => @authentications
  #   else
  #     render :json => false, :status => :not_found
  #   end
  # end
end
