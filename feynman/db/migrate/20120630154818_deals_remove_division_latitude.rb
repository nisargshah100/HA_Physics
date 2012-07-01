class DealsRemoveDivisionLatitude < ActiveRecord::Migration
  def change
    remove_column :deals, :division_latitude
    remove_column :deals, :division_longitude
  end
end
