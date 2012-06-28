class Api::V1::EventsController < ApplicationController

  def index
    deals = Deal.where(:end_date.gt => DateTime.now, :division_latlon => { '$near' => [38.9087, -77.0414], '$maxDistance' => 32.fdiv(111.12)}).limit(Deal.count)
    conds = []

    # Narrow the scope
    EVENT_CATEGORIES.each do |cat|
      conds << {"$and" => [{"original_category" => cat.category_name}, {"original_subcategory" => cat.subcategory_name}]}
    end

    conds << {"$or" => [{"title" => /(for Two)|(for Four)/i}]}
    deals = deals.any_of(conds)

    deals = deals.page(params[:page]).per(params[:limit])

    render :json => deals
  end

end
