class DealsAddOriginalSubcategory < ActiveRecord::Migration
  def change
    add_column :deals, :original_subcategory, :string
  end
end
