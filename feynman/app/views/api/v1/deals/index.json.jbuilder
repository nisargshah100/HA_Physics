json.array!(@deals) do |json, deal|
  json.(deal, :id, :original_id, :date_added, :end_date,
    :title, :subtitle, :affiliate_url, :original_url,
    :image_url, :source, :division_name, :latitude, :longitude,
    :original_category, :original_subcategory, :category, :last_purchase_count,
    :sold_out )
  json.image_url deal.image_url.gsub('100_q60_', '275_q100')
  json.price deal.price.to_s
  json.value (deal.value + deal.price).to_s
end