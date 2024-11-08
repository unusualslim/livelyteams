class ChangeLaborHoursToFloatInCaseComments < ActiveRecord::Migration[7.0]
  def change
    change_column :case_comments, :labor_hours, :float
  end
end
