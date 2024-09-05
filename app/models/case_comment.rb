class CaseComment < ApplicationRecord
  belongs_to :user
  belongs_to :case

  after_create :notify_case_comment

  def notify_case_comment
    self.case.send(:notify_case_comment) # Using `send` to call the private method
  end

  private
end
