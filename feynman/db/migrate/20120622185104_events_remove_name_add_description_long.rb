class EventsRemoveNameAddDescriptionLong < ActiveRecord::Migration
  def change
    add_column :events, :description_short, :string
    add_column :events, :description_long, :string
    remove_column :events, :name
  end
end
