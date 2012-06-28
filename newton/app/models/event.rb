class Event
  class Category
    attr_accessor :category_name, :subcategory_name 

    def initialize(cat_name, subcat_name)
      self.category_name = cat_name
      self.subcategory_name = subcat_name
    end
  end
end
