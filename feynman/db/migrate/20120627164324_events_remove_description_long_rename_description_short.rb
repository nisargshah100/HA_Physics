class EventsRemoveDescriptionLongRenameDescriptionShort < ActiveRecord::Migration
  def change
    remove_column :events, :description_long
    remove_column :events, :description
    rename_column :events, :description_short, :description
  end
end
