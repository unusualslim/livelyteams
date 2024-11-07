class User < ApplicationRecord
  attr_accessor :current_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
#  devise :database_authenticatable, :registerable,
 #        :recoverable, :rememberable, :trackable, :validatable
         # :confirmable
  has_many :cases
  has_many :tasks
  has_many :comment
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

#  has_many :team_members
#  has_many :teams, through: :team_members
#  has_many :roles, through: :team_members

  def notify_method?(event)
    case event
    when :new_case
      new_case_created? && (notification_method.include?('text') || notification_method.include?('both'))
    when :update_case
      updated_case? && (notification_method.include?('text') || notification_method.include?('both'))
    when :new_comment
      new_comment? && (notification_method.include?('text') || notification_method.include?('both'))
    when :billable_case
      billable_case? && (notification_method.include?('text') || notification_method.include?('both'))
    when :closed_case
      closed_case? && (notification_method.include?('text') || notification_method.include?('both'))
    else
      false
    end
  end
end