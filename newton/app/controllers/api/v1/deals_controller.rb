class Api::V1::DealsController < ApiController
  def index
    if deals = Deal.by_params(params).page(params[:page]).per(params[:limit])
      render :json => deals, status: :ok
    else
      render status: :not_found
    end
  end

  def show
    if deal = Deal.find_by_id(params[:id])
      render :json => deal, status: :ok
    else
      render status: :not_found
    end
  end

  def fetch
    Thread.new do
      puts %x[rake ls:fetch_deals]
      puts %x[rake groupon:fetch_divisions]
      puts %x[rake groupon:fetch_deals]
    end

    render :json => true
  end
end
