class DivisionsController < ApplicationController

  def index
    render :json => DealAnalysis.last.divisions
  end

end
