json.array!(@messages) do |json, message|
  json.(message, :body, :status)
  json.created_at message.pretty_time
  json.sender do |json|
    json.url profile_path(message.sender.display_name)
    json.display_name message.sender.display_name
    json.image message.sender.image
  end
end