class Case < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :status
  belongs_to :severity
  belongs_to :requested_by, :class_name => 'User'
  belongs_to :assigned_to, :class_name => 'User'
 
  has_many :case_locations
  has_many :locations, through: :case_locations, dependent: :destroy

  has_many :case_comments, :dependent => :destroy

  has_many_attached :files, :dependent => :destroy

  has_many :case_users, :dependent => :destroy
  has_many :users, through: :case_users

  def notify_assigned_user
      assigned_user = User.find_by(id: assigned_to_id)
      if assigned_user
        phone_number = assigned_user.phone_number
        message = "A case assigned to you has been updated: https://livelyteams.com/cases/#{id}"
        puts "Sending Twilio message to #{phone_number}: #{message}"
        TwilioService.send_text_message(phone_number, message)
      end
  end
end
