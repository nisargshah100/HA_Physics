class Api::V1::DealsController < ApiController
  before_filter :authenticate, :only => [:index]

  def index
    if params[:lat] && params[:lon] && params[:radius]
      render :json => Deal.near([params[:lat], params[:lon]], params[:radius])
    else
      params[:page] = 0 if params[:page].nil?
      deals = Deal.active.near([current_user.latitude, current_user.longitude], 20).most_popular.page(0).per(18)
      render :json => deals
    end
  end
end
