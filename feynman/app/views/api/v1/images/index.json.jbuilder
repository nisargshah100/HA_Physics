json.array!(@images) do |json, image|
  json.(image, :user_id, :width, :height, :image_url)
  json.large_image_url image.large_image_url
  json.small_image_url image.small_image_url
end