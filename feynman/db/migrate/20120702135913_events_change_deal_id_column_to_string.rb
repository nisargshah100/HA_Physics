class EventsChangeDealIdColumnToString < ActiveRecord::Migration
  def change
    change_column :events, :deal_id, :string
  end
end
