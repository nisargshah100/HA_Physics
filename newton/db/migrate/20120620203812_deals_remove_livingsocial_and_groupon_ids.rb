class DealsRemoveLivingsocialAndGrouponIds < ActiveRecord::Migration
  def change
    remove_column :deals, :livingsocial_id
    remove_column :deals, :groupon_id
    add_column :deals, :original_id, :string
  end
end
