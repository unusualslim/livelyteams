class UpdateNotificationPreferences < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :new_case_created_text
    remove_column :users, :new_case_created_email
    remove_column :users, :updated_case_text
    remove_column :users, :updated_case_email
    remove_column :users, :new_comment_text
    remove_column :users, :new_comment_email
    remove_column :users, :billable_case_text
    remove_column :users, :billable_case_email
    remove_column :users, :closed_case_text
    remove_column :users, :closed_case_email

    # Add new columns
    add_column :users, :new_case_created, :boolean, default: true
    add_column :users, :updated_case, :boolean, default: true
    add_column :users, :new_comment, :boolean, default: true
    add_column :users, :billable_case, :boolean, default: true
    add_column :users, :closed_case, :boolean, default: true

    add_column :users, :notification_method, :string, default: 'email'
  end
end
