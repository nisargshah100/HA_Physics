class UserDetail < ActiveRecord::Base
  attr_accessible :user, :user_id, :image, :zipcode,
    :gender, :gender_preference, :age_range_lower, :age_range_upper,
    :employment, :education, :faith, :faith_level, :political_affiliation,
    :political_affiliation_level, :race, :children_preference, :height_feet,
    :height_inches, :exercise_level, :drinking_level, :smoking_level

  validates :zipcode, :format => { :with => /^[0-9]{5}$/, :message => "must be 5 digits" }
  validate :ensure_valid_country

  geocoded_by :zipcode

  reverse_geocoded_by :latitude, :longitude do |user_detail, results|
    if geo = results.first
      user_detail.city    = geo.city
      user_detail.state   = geo.state
      user_detail.country = geo.country
    end
  end

  before_create :geocode          # auto-fetch coordinates
  before_create :reverse_geocode

  belongs_to :user

  def complete?
    true if zipcode.nil? || gender.nil? || gender_preference.nil?
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

  def ensure_valid_country
    country == "USA"
  end
end