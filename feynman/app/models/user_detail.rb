class UserDetail < ActiveRecord::Base
  attr_accessible :user, :user_id, :image, :zip_id,
    :gender, :gender_preference, :age_range_lower, :age_range_upper,
    :employment, :education, :faith, :faith_level, :political_affiliation,
    :political_affiliation_level, :race, :children_preference, :height_feet,
    :height_inches, :exercise_level, :drinking_level, :smoking_level

  attr_writer :current_step

  geocoded_by :zip_id
  after_validation :geocode          # auto-fetch coordinates

  belongs_to :user
  belongs_to :zip

  scope :within_miles_of_zip, lambda{|radius, zip|
    # Get the parameters for the search
    area = zip.area_for(radius)

    # now find all zip codes that are within 
    # these min/max lat/lon bounds and return them
    # weed out any zip codes that fall outside of the search radius
    { :select => "#{UserDetail.columns.map{|c| "user_details.#{c.name}"}.join(', ')}, sqrt( 
        pow(#{area[:lat_miles]} * (zips.lat - #{zip.lat}),2) + 
        pow(#{area[:lon_miles]} * (zips.lon - #{zip.lon}),2)) as distance",
      :joins => :zip,
      :conditions => "(zips.lat BETWEEN #{area[:min_lat]} AND #{area[:max_lat]}) 
        AND (zips.lon BETWEEN #{area[:min_lon]} AND #{area[:max_lon]}) 
        AND sqrt(pow(#{area[:lat_miles]} * (zips.lat - #{zip.lat}),2) + 
        pow(#{area[:lon_miles]} * (zips.lon - #{zip.lon}),2)) <= #{area[:radius]}",
      :order => "distance"}
  }

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[user_preference user_info complete]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  def complete?
    status == "complete"
  end 

  def set_complete
    update_attribute(:status, "complete")
  end

  def within_miles(radius)
    self.class.within_miles_of_zip(radius, zip)
  end

  def location
    "#{zip.city.titleize}, #{zip.state}" if zip
  end

  def orientation
    if gender_preference =~ /^both/i
      return "Bisexual"
    elsif gay?
      return "Gay"
    elsif gender != gender_preference
      return "Straight"
    end
  end

  def gay?
    if gender =~ /^male/i && gender_preference =~ /^men/i || gender =~ /^female/i && gender_preference =~ /^women/i
      true
    else
      false
    end
  end

  def height
    if height_feet && height_inches
      "#{height_feet}\"#{height_inches}"
    end
  end

  def objective_pronoun
    gender =~ /^male/i ? "him" : "her"
  end

  def image
    "/assets/default_#{gender.downcase}_250.png" if @image.nil?
  end
end