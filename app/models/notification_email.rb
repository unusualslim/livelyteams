class NotificationEmail < ApplicationRecord
  belongs_to :user

  before_validation :normalize_email

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: { scope: :user_id, case_sensitive: false }

  scope :active, -> { where(active: true) }

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end