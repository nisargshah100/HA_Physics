class Image < ActiveRecord::Base
  attr_accessible :user, :user_id, :image_url, :width, :height
  belongs_to :user

  validates_uniqueness_of :image_url, :scope => :user_id

  def small_image_url
    image_url.gsub("_6", "_5")
  end

  def large_image_url
    image_url.gsub("_6", "_7")
  end
end