class Zip < ActiveRecord::Base
  # Credit to Paul Barry
  set_primary_key :code

  attr_accessible :city, :code, :lat, :lon, :state
  
  has_many :user_details
  has_many :users, :through => :user_details

  def self.code(code)
    first(:conditions => {:code => code})
  end
  
  # Returns a hash with values that can be used 
  # to perform a proximity search query
  def area_for(radius)
    area = {}
    area[:radius] = radius.to_f
    area[:lat_miles] = 69.172  #this is constant
    
    #longitude miles varies based on latitude, that is calculated here
    area[:lon_miles] = (area[:lat_miles] * Math.cos(lat * (Math::PI/180))).abs

    area[:lat_degrees] = radius/area[:lat_miles]  #radius in degrees latitude
    area[:lon_degrees] = radius/area[:lon_miles]  #radius in degrees longitude

    #now set min and max lat and long accordingly
    area[:min_lat] = lat - area[:lat_degrees]
    area[:max_lat] = lat + area[:lat_degrees]
    area[:min_lon] = lon - area[:lon_degrees]
    area[:max_lon] = lon + area[:lon_degrees]    
      
    area  
  end
end
