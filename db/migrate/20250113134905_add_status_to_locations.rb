class AddStatusToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :status, :string
  end
end
