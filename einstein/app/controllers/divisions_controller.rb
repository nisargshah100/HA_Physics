class DivisionsController < ApplicationController

  def index
    render :json => Deal.where(:source => 'LivingSocial').select { |d| d.division_name != nil }.map { |d| d.division_name }.uniq.sort_by { |d| d }
  end

end
