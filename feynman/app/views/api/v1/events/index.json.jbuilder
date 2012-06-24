json.array!(@events) do |json, event|
  json.(event, :source, :deal_id, :description_long, :description_short, :user_id, :date)
  json.user do |json|
    json.user_id event.user.id
    json.display_name event.user.display_name
    json.image event.user.image
    json.location event.user.location
  end
end