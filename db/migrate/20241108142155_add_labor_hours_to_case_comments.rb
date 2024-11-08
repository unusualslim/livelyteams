class AddLaborHoursToCaseComments < ActiveRecord::Migration[7.0]
  def change
    add_column :case_comments, :labor_hours, :integer
  end
end
