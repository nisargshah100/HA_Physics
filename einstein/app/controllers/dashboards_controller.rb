class DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def velocity 
    render :json => {
      :groupon => JSON.parse(DealAnalysis.last.groupon_deal_velocity),
      :livingsocial => JSON.parse(DealAnalysis.last.livingsocial_deal_velocity)
    }
  end

  def districts
    render :json => {
      :groupon => JSON.parse(DealAnalysis.last.groupon_top_districts),
      :livingsocial => JSON.parse(DealAnalysis.last.livingsocial_top_districts)
    }
  end

  def projected_revenue
    deals = Deal.where(:source => "LivingSocial")
    deals = deals.where(:title => /#{params[:q]}/i) unless params[:q].blank?
    deals = DealAnalysis.unique_deals(deals)

    render :json => RevenueProjection.compute(deals).sort_by { |r| -r[0] }[0..10]
  end

end
