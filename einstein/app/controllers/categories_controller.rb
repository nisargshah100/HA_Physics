class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
    render :json => Deal.where(:source => 'LivingSocial').select { |d| d.original_subcategory != nil }.map { |d| d.original_subcategory }.uniq.sort_by { |d| d }
  end
end
