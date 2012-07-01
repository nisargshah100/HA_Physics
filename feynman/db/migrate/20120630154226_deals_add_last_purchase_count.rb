class DealsAddLastPurchaseCount < ActiveRecord::Migration
  def change
    add_column :deals, :last_purchase_count, :integer
  end
end
