class Image < ActiveRecord::Base
  attr_accessible :user, :user_id, :image_url, :width, :height

end
