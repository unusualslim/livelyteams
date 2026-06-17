class AddBillToAddressToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :bill_to_name, :string
    add_column :locations, :bill_to_address1, :string
    add_column :locations, :bill_to_address2, :string
    add_column :locations, :bill_to_city, :string
    add_column :locations, :bill_to_state, :string
    add_column :locations, :bill_to_zip, :string
  end
end
