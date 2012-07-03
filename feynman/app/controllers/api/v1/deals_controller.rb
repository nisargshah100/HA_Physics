class Api::V1::DealsController < ApiController
  before_filter :authenticate, :only => [:index]
  def index
    if params[:zipcode] && params[:radius]
      @deals = Deal.most_popular.near(params[:zipcode], params[:radius].to_i).active.page(params[:page])
    else
      @deals = Deal.most_popular.near(current_user.zipcode.to_s, 10).active.page(params[:page])
    end
  end
end
