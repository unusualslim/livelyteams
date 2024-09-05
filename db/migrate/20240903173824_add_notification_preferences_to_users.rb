class AddNotificationPreferencesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :new_case_created_text, :boolean
    add_column :users, :new_case_created_email, :boolean
    add_column :users, :updated_case_text, :boolean
    add_column :users, :updated_case_email, :boolean
    add_column :users, :new_comment_text, :boolean
    add_column :users, :new_comment_email, :boolean
    add_column :users, :billable_case_text, :boolean
    add_column :users, :billable_case_email, :boolean
    add_column :users, :closed_case_text, :boolean
    add_column :users, :closed_case_email, :boolean
  end
end
