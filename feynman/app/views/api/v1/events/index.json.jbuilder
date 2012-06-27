json.array!(@events) do |json, event|
  json.(event, :source, :deal_id, :description_long, :description_short, :user_id, :date)
  json.user do |json|
    json.url user_url(event.user)
    json.user_id event.user.id
    json.display_name event.user.display_name
    json.image event.user.image
    json.age event.user.age
    json.gender event.user.gender
    json.orientation event.user.orientation
    json.location event.user.location
  end
end