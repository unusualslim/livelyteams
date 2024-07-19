class AddRequestedByToSupportCases < ActiveRecord::Migration[7.0]
  def change
    add_column :support_cases, :requested_by, :string
  end
end
