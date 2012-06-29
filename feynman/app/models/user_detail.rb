class UserDetail < ActiveRecord::Base
  attr_accessible :user, :user_id, :image, :zipcode,
    :gender, :gender_preference, :age_range_lower, :age_range_upper,
    :employment, :education, :faith, :faith_level, :political_affiliation,
    :political_affiliation_level, :race, :children_preference, :height_feet,
    :height_inches, :exercise_level, :drinking_level, :smoking_level

  attr_writer :current_step

  geocoded_by :zipcode
  after_validation :geocode          # auto-fetch coordinates

  reverse_geocoded_by :latitude, :longitude do |user_detail, results|
    if geo = results.first
      user_detail.city    = geo.city
      user_detail.state   = geo.state
    end
  end
  after_validation :reverse_geocode

  belongs_to :user

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

  def location
    "#{city.titleize}, #{state}" if city && state
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