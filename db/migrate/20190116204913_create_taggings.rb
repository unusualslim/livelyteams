class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.belongs_to :tag, foreign_key: true
      t.belongs_to :asset, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
