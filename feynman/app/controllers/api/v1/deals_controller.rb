class Api::V1::DealsController < ApiController
  before_filter :authenticate, :only => [:index]
  def index
    if params[:zipcode] && params[:radius]
      @deals = Deal.near(params[:zipcode], params[:radius]).active.most_popular.page(params[:page])
    else
      @deals = Deal.near_user(current_user).page(params[:page])
    end
  end
end
