class User < ApplicationRecord
  attr_accessor :current_password
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable

  has_many :tasks
  has_many :comments
  has_many :case_users
  has_many :cases, through: :case_users
  has_many :team_members, dependent: :destroy
  has_many :teams, through: :team_members
  has_many :notification_emails, dependent: :destroy

  after_create :assign_default_external_membership

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

  def role_names
    team_members.includes(:role).map { |tm| tm.role&.role }.compact
  end

  def internal?
    role_names.include?("internal_admin") || role_names.include?("internal_user")
  end

  def external?
    role_names.include?("external_admin") || role_names.include?("external_user")
  end

  def current_team
    teams.first
  end

  def move_to_team!(team_name, role_name)
    team = Team.find_by!(name: team_name)
    role = Role.find_by!(role: role_name)

    tm = team_members.first

    if tm.nil?
      team_members.create!(team: team, role: role)
    else
      tm.update!(team: team, role: role)
    end
  end

  def notification_recipients
    ([email] + notification_emails.active.pluck(:email)).compact.uniq
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

  private

  def assign_default_external_membership
    external_team = Team.find_by(name: "External")
    external_role = Role.find_by(role: "external_user")
    return unless external_team && external_role

    TeamMember.find_or_create_by!(user: self, team: external_team, role: external_role)
  end
end