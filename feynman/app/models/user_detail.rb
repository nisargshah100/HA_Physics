class UserDetail < ActiveRecord::Base
  attr_accessible :user, :user_id, :birthday, :image, :zipcode, :display_name,
    :gender, :gender_preference, :age_range_lower, :age_range_upper,
    :employment, :education, :faith, :faith_level, :political_affiliation,
    :political_affiliation_level, :race, :children_preference, :height_feet,
    :height_inches, :exercise_level, :drinking_level, :smoking_level

  belongs_to :user

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end

  def orientation
    if gender_preference == "Both"
      return "Bisexual"
    elsif gender == gender_preference
      get_gay_string
    elsif gender != gender_preference
      return "Straight"
    end
  end

  def get_gay_string
    gender =~ /male/i ? "Gay" : "Lesbian"
  end
end