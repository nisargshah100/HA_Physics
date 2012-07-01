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

  def deal_probability
    term, time, loc = params[:term], Chronic.parse(params[:time]), params[:loc]
    deals = Deal.where(:title => /#{term}/i, :division_name => /#{loc}/i, :source => "LivingSocial")

    render :json => {
      :analysis => DealRunProbability.compute(deals, time.to_date),
      :deals => deals.select { |d| d.date_added != nil }.sort_by { |d| d.date_added }.reverse
    }
  end

end
