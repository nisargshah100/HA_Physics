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

end
