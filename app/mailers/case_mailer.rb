class CaseMailer < ApplicationMailer
  default from: 'no-reply@livelyteams.com'

  def send_to_ap(file)
    @file = file
    attachments[@file.filename.to_s] = @file.download
    case_id = @file.record.id # Get the case ID from the attachment's associated case

    mail(
      to: 'johnsmarr@perrybrothersoil.com',
      subject: "New Photo from LivelyTeams Case "
    )
  end

  private

  def email_enabled?(user)
    return false if user.nil?
    user.notification_method == 'email' || user.notification_method == 'both'
  end

  def add_recipients!(recipient_array, user, preference_flag)
    return if user.nil?
    return unless email_enabled?(user)

    # preference_flag is a symbol like :new_case_created, :updated_case, etc.
    return unless user.respond_to?(preference_flag) && user.public_send(preference_flag)

    # notification_recipients returns [primary_email + extra active emails]
    recipient_array.concat(user.notification_recipients)
  end

  public

  def new_case_email(new_case)
    @case = new_case
    recipients = []

    @case.case_users.each do |cu|
      add_recipients!(recipients, cu.user, :new_case_created)
    end

    add_recipients!(recipients, @case.requested_by, :new_case_created)
    add_recipients!(recipients, @case.assigned_to, :new_case_created)

    recipients = recipients.compact.uniq

    mail(
      to: recipients,
      subject: "[#{@case.severity.severity}] Case No. #{@case.id} #{@case.subject}"
    ) unless recipients.empty?
  end

  def update_case_email(updated_case)
    @case = updated_case
    recipients = []

    @case.case_users.each do |cu|
      add_recipients!(recipients, cu.user, :updated_case)
    end

    add_recipients!(recipients, @case.requested_by, :updated_case)
    add_recipients!(recipients, @case.assigned_to, :updated_case)

    recipients = recipients.compact.uniq

    mail(
      to: recipients,
      subject: "Case No. #{@case.id} has been updated"
    ) unless recipients.empty?
  end

  def new_comment_case_email(updated_case)
    @case = updated_case
    recipients = []

    @case.case_users.each do |cu|
      add_recipients!(recipients, cu.user, :new_comment)
    end

    add_recipients!(recipients, @case.requested_by, :new_comment)
    add_recipients!(recipients, @case.assigned_to, :new_comment)

    recipients = recipients.compact.uniq

    mail(
      to: recipients,
      subject: "Case No. #{@case.id} has a new comment"
    ) unless recipients.empty?
  end

  def inspectable_case_email(updated_case)
    @case = updated_case
    recipients = []

    @case.case_users.each do |cu|
      add_recipients!(recipients, cu.user, :inspectable_case)
    end

    add_recipients!(recipients, @case.requested_by, :inspectable_case)
    add_recipients!(recipients, @case.assigned_to, :inspectable_case)

    recipients = recipients.compact.uniq

    mail(
      to: recipients,
      subject: "Case No. #{@case.id} is ready for inspection"
    ) unless recipients.empty?
  end

  def billable_case_email(updated_case)
    @case = updated_case
    recipients = []

    @case.case_users.each do |cu|
      add_recipients!(recipients, cu.user, :billable_case)
    end

    add_recipients!(recipients, @case.requested_by, :billable_case)
    add_recipients!(recipients, @case.assigned_to, :billable_case)

    recipients = recipients.compact.uniq

    mail(
      to: recipients,
      subject: "Case No. #{@case.id} is complete and ready for billing"
    ) unless recipients.empty?
  end

  def closed_case_email(updated_case)
    @case = updated_case
    recipients = []

    @case.case_users.each do |cu|
      add_recipients!(recipients, cu.user, :closed_case)
    end

    add_recipients!(recipients, @case.requested_by, :closed_case)
    add_recipients!(recipients, @case.assigned_to, :closed_case)

    recipients = recipients.compact.uniq

    mail(
      to: recipients,
      subject: "Case No. #{@case.id} is now closed."
    ) unless recipients.empty?
  end
end