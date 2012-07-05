json.array!(@events) do |json, event|
  json.(event, :id, :source, :deal_id, :description, :user_id, :date, :status)
  json.user do |json|
    json.url profile_path(event.user.slug)
    json.user_id event.user.id
    json.display_name event.user.display_name
    json.image event.user.image
    json.age event.user.age
    json.gender event.user.gender.capitalize
    json.orientation event.user.orientation
    json.location event.user.location
  end
  json.deal do |json|
    json.(event.deal, :original_id, :date_added, :end_date,
      :title, :subtitle, :affiliate_url, :original_url,
      :image_url, :source, :division_name, :latitude, :longitude,
      :original_category, :original_subcategory, :category, :last_purchase_count,
      :sold_out )
    json.image_url event.deal.image_url.gsub('100_q60_', '275_q100')
    json.price event.deal.price.to_s
    json.value (event.deal.value + event.deal.price).to_s
  end if event.deal
end