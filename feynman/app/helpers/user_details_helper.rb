module UserDetailsHelper

  def get_children_preferences
    prefs = [ "", "Have them", "Want them now", "Maybe someday", "Not for me"]
    make_hash(prefs)
  end

  def get_races
    prefs = [ "", "Asian", "Black", "Indian", "Hispanic/Latin", "Middle Eastern", 
      "Native American", "Pacific Islander", "White", "Other" ]
    make_hash(prefs)
  end

  def get_faiths
    prefs = [ "", "Agnostic", "Atheist", "Christian", "Catholic", "Buddhist", 
      "Hindu", "Jewish", "Muslim", "Spiritual", "Other", 
      "None", "No Comment" ]
    make_hash(prefs)
  end

  def get_political_affiliations
    prefs = [ "", "Liberal", "Progressive", "Conservative", 
      "Independent", "Centrist", "Anarchist", "Socialist", "Libertarian", "Other", 
      "None", "No Comment" ]
    make_hash(prefs)
  end

  def get_educations
    prefs = [ "", "High School", "Some College", "College", 
      "Masters", "MFA", "Law School", "Medical School", "MBA", "PhD" ]
    make_hash(prefs)
  end

  def make_hash(values)
    hash = {}
    values.each_with_index { |value, index| hash[index.to_s] = value }
    hash
  end
end
