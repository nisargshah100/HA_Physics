class DealsAddLatLon < ActiveRecord::Migration
  def change
    add_column :deals, :latitude, :float
    add_column :deals, :longitude, :float
    add_column :deals, :city, :string
    add_column :deals, :state, :string
    add_column :deals, :country, :string
  end
end
