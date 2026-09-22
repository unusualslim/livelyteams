class CreateCaseCustomLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :case_custom_locations do |t|
      t.references :case, null: false, foreign_key: true
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
