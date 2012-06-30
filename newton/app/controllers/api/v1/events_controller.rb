class Api::V1::EventsController < ApplicationController

  def index
    deals = Deal.by_params(params).where(:end_date.gt => DateTime.now).limit(Deal.count)

    excludes = ['cleaning', 'family', 'spa', 'treatment', 'stay', 'paintball', 'month', 'year', 'unlimited', 'children']
    conds = []

    excludes.each do |ex|
      conds << {"$or" => [{"title" => /^((?!#{ex}).)*$/i }]}
      conds << {"$or" => [{"subtitle" => /^((?!#{ex}).)*$/i }]}
    end

    deals = deals.all_of(conds)

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
