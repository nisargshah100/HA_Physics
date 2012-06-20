class Deal < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :livingsocial_id, :groupon_id, :date_added, :end_date, 
                  :price_cents, :value_cents, :title, :subtitle, :affiliate_url, 
                  :original_url, :image_url, :source
end
