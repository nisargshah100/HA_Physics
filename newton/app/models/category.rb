class Category
  include Mongoid::Document
  
  field :category
  field :original_category

  def self.from_original_category(category)
    cat = where(:original_category => category).first
    cat.category if cat
  end

  validates_uniqueness_of :original_category
  
end
