class UserDetail < ActiveRecord::Base
  attr_accessible :user, :user_id, :image_url, :zipcode,
    :gender, :gender_preference, :age_range_lower, :age_range_upper,
    :employment, :education, :faith, :faith_level, :political_affiliation,
    :political_affiliation_level, :race, :children_preference, :height, 
    :exercise_level, :drinking_level, :smoking_level, :city, :state, :country

  validates :zipcode, :format => { :with => /^[0-9]{5}$/, :message => "must be 5 digits" }

  geocoded_by :zipcode

  GENDER_ORIENTATION = { "straight guys"  => [ "male", "women" ],
                         "bi guys"        => [ "male", "both" ],
                         "gay guys"       => [ "male", "men" ],
                         "straight women" => [ "female", "men" ],
                         "bi women"       => [ "female", "both" ],
                         "gay women"      => [ "female", "women" ] }

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

  def nearby_compatible_user_details(radius=10)
    compatible_user_details.near(zipcode, radius)
  end

  def compatible_user_details
    lookup = {
      ["male", "women"] => "gender = 'female' AND (gender_preference = 'both' OR gender_preference = 'men')",
      ["male", "both"]  => "(gender = 'male' AND (gender_preference = 'both' OR gender_preference = 'men')) OR (gender = 'female' AND (gender_preference = 'men' OR gender_preference = 'both'))",
      ["male", "men"]  => "gender = 'male' AND (gender_preference = 'both' OR gender_preference = 'men')",
      ["female", "women"] => "gender = 'female' AND (gender_preference = 'both' OR gender_preference = 'women')",
      ["female", "both"]  => "(gender = 'male' AND (gender_preference = 'both' OR gender_preference = 'women')) OR (gender = 'female' AND (gender_preference = 'women' OR gender_preference = 'both'))",
      ["female", "men"]  => "gender = 'male' AND (gender_preference = 'both' OR gender_preference = 'women')",
    }

    UserDetail.where(lookup[gender_orientation_array])
  end

  def gender_orientation_array
    [ gender, gender_preference ]
  end

  def get_gender_orientation
    GENDER_ORIENTATION.select{ |key, value| value == gender_orientation_array }.keys.first
  end

  def gay?
    get_gender_orientation.split(" ").first =~ /gay/ ? true : false
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

  def objective_pronoun
    gender =~ /^male/i ? "him" : "her"
  end

  def image
    self.gender ||= "male"
    image_url.blank? ? "/assets/default_#{gender.downcase}_250.png" : image_url
  end
end