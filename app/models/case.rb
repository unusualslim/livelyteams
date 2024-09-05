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

  after_create :notify_new_case
  after_update :notify_case_update
  after_update :notify_billable_case, if: :billable?
  after_update :notify_case_closed, if: :closed?

  def notify_assigned_user
    assigned_user = User.find_by(id: assigned_to_id)
    if assigned_user
      phone_number = assigned_user.phone_number
      message = "A case assigned to you has been updated: https://livelyteams.com/cases/#{id}"
      puts "Sending Twilio message to #{phone_number}: #{message}"
      TwilioService.new.send_sms(phone_number, message)
    end
  end

  def notify_case_comment
    notify_users(:new_comment)
  end

  def billable?
    status.status == 'Billable'
  end

  def closed?
    status.status == 'Closed'
  end

  def notify_users(event)
    message = case event
              when :new_case
                "A new case has been created: https://livelyteams.com/cases/#{id}"
              when :update_case
                "Case No. #{id} has been updated: https://livelyteams.com/cases/#{id}"
              when :new_comment
                "Case No. #{id} has a new comment: https://livelyteams.com/cases/#{id}"
              when :billable_case
                "Case No. #{id} is complete and ready for billing: https://livelyteams.com/cases/#{id}"
              when :closed_case
                "Case No. #{id} is now closed: https://livelyteams.com/cases/#{id}"
              else
                "Case No. #{id} has been updated: https://livelyteams.com/cases/#{id}"
              end

    recipients = users_to_notify(event)
    recipients.each do |user|
      if user.notify_method?(event)
        TwilioService.new.send_sms(user, message)
      end
    end
  end

  private

  def users_to_notify(event)
    users_to_notify = []

    case event
    when :new_case, :update_case, :new_comment, :billable_case, :closed_case
      users_to_notify.concat(case_users.map(&:user))
      users_to_notify << requested_by
      users_to_notify << assigned_to
    end

    users_to_notify.uniq
  end

  def notify_case_update
    notify_users(:update_case)
  end

  def notify_new_case
    notify_users(:new_case)
  end

  def notify_case_comment
    notify_users(:new_comment)
  end

  def notify_billable_case
    notify_users(:billable_case)
  end

  def notify_case_closed
    notify_users(:closed_case)
  end
end