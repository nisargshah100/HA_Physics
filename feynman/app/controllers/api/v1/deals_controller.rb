class Api::V1::DealsController < ApiController
  before_filter :authenticate, :only => [:index]

  def index
    if params[:lat] && params[:lon] && params[:radius]
      @deals = Deal.near([params[:lat], params[:lon]], params[:radius])
    else
      @deals = Deal.near_user(current_user).page(params[:page])
    end
  end
end
