class EventsAddColumnStatus < ActiveRecord::Migration
  def change
    add_column :events, :status, :string, :default => "active"
  end
end
