class User < ApplicationRecord
  attr_accessor :current_password
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable

  has_many :tasks
  has_many :comments
  has_many :case_users
  has_many :cases, through: :case_users

  def full_name
    ([first_name, last_name] - ['']).compact.join(' ')
  end

  scope :active, -> { where(active: true) }

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    "Your account has been deactivated. Please contact the administrator."
  end

  def notify_method?(event)
    case event
    when :new_case
      new_case_created? && notification_method.include?('text')
    when :update_case
      updated_case? && notification_method.include?('text')
    when :new_comment
      new_comment? && notification_method.include?('text')
    when :billable_case
      billable_case? && notification_method.include?('text')
    when :closed_case
      closed_case? && notification_method.include?('text')
    else
      false
    end
  end
end
