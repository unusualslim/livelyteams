class AddPhoneToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :phone, :string
  end
end
