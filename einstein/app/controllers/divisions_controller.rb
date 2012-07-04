class DivisionsController < ApplicationController

  def index
    render :json => Deal.where(:source => 'LivingSocial').by_division(params)
  end

end
