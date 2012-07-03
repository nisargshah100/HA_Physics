json.image do |json|
  json.user_id @image.user_id
  json.width @image.width
  json.height @image.height
  json.image_url @image.image_url
  json.large_image_url @image.large_image_url
  json.small_image_url @image.small_image_url
end