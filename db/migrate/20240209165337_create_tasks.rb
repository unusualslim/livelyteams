class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :task do |t|
      t.string :subject
      t.references :location, foreign_key: true
      t.references :status, foreign_key: true
      t.text :description
      t.references :severity, foreign_key: true
      t.references :asset, foreign_key: true
      t.references :task_list, foreign_key: true
      t.references :requested_by, foreign_key: { to_table: :users }
      t.references :assigned_to, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
