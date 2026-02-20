class CreateNotificationEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_emails do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email, null: false
      t.boolean :active, null: false, default: true
      t.datetime :verified_at

      t.timestamps
    end

    # prevents the same email being added twice for the same user
    add_index :notification_emails, [:user_id, :email], unique: true
  end
end