class MigrateLocationNoteToActionText < ActiveRecord::Migration[7.0]
  include ActionView::Helpers::TextHelper
  def change
    rename_column :locations, :note, :note_old
    Location.all.each do |location|
      location.update_attribute(:note, simple_format(location.note_old))
    end
    remove_column :locations, :note_old

  end
end
