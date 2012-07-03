class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
    render :json => Deal.where(:source => 'LivingSocial').by_category(params)
  end
end
