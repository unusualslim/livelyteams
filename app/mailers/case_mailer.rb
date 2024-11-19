class CaseMailer < ApplicationMailer
  default from: 'no-reply@livelyteams.com'

  def new_case_email(new_case)
    @case = new_case
    recipient = []

    @case.case_users.each do |cu|
      if cu.user.new_case_created && (cu.user.notification_method == 'email' || cu.user.notification_method == 'both')
        recipient.push(cu.user.email)
      end
    end

    if @case.requested_by.new_case_created && (@case.requested_by.notification_method == 'email' || @case.requested_by.notification_method == 'both')
      recipient.push(@case.requested_by.email)
    end

    if @case.assigned_to.new_case_created && (@case.assigned_to.notification_method == 'email' || @case.assigned_to.notification_method == 'both')
      recipient.push(@case.assigned_to.email)
    end

    mail(
      to: recipient.uniq,
      subject: "[#{@case.severity.severity}] Case No. #{@case.id} #{@case.subject}"
    ) unless recipient.empty?
  end

  def update_case_email(updated_case)
    @case = updated_case
    recipient = []

    @case.case_users.each do |cu|
      if cu.user.updated_case && (cu.user.notification_method == 'email' || cu.user.notification_method == 'both')
        recipient.push(cu.user.email)
      end
    end

    if @case.requested_by.updated_case && (@case.requested_by.notification_method == 'email' || @case.requested_by.notification_method == 'both')
      recipient.push(@case.requested_by.email)
    end

    if @case.assigned_to.updated_case && (@case.assigned_to.notification_method == 'email' || @case.assigned_to.notification_method == 'both')
      recipient.push(@case.assigned_to.email)
    end

    mail(
      to: recipient.uniq,
      subject: "Case No. #{@case.id} has been updated"
    ) unless recipient.empty?
  end

  def new_comment_case_email(updated_case)
    @case = updated_case
    recipient = []

    @case.case_users.each do |cu|
      if cu.user.new_comment && (cu.user.notification_method == 'email' || cu.user.notification_method == 'both')
        recipient.push(cu.user.email)
      end
    end

    if @case.requested_by.new_comment && (@case.requested_by.notification_method == 'email' || @case.requested_by.notification_method == 'both')
      recipient.push(@case.requested_by.email)
    end

    if @case.assigned_to.new_comment && (@case.assigned_to.notification_method == 'email' || @case.assigned_to.notification_method == 'both')
      recipient.push(@case.assigned_to.email)
    end

    mail(
      to: recipient.uniq,
      subject: "Case No. #{@case.id} has a new comment"
    ) unless recipient.empty?
  end

  def inspectable_case_email(updated_case)
    @case = updated_case
    recipient = []

    @case.case_users.each do |cu|
      if cu.user.inspectable_case && (cu.user.notification_method == 'email' || cu.user.notification_method == 'both')
        recipient.push(cu.user.email)
      end
    end

    if @case.requested_by.inspectable_case && (@case.requested_by.notification_method == 'email' || @case.requested_by.notification_method == 'both')
      recipient.push(@case.requested_by.email)
    end

    if @case.assigned_to.inspectable_case && (@case.assigned_to.notification_method == 'email' || @case.assigned_to.notification_method == 'both')
      recipient.push(@case.assigned_to.email)
    end

    mail(
      to: recipient.uniq,
      subject: "Case No. #{@case.id} is ready for inspection"
    ) unless recipient.empty?
  end

  def billable_case_email(updated_case)
    @case = updated_case
    recipient = []

    @case.case_users.each do |cu|
      if cu.user.billable_case && (cu.user.notification_method == 'email' || cu.user.notification_method == 'both')
        recipient.push(cu.user.email)
      end
    end

    if @case.requested_by.billable_case && (@case.requested_by.notification_method == 'email' || @case.requested_by.notification_method == 'both')
      recipient.push(@case.requested_by.email)
    end

    if @case.assigned_to.billable_case && (@case.assigned_to.notification_method == 'email' || @case.assigned_to.notification_method == 'both')
      recipient.push(@case.assigned_to.email)
    end

    mail(
      to: recipient.uniq,
      subject: "Case No. #{@case.id} is complete and ready for billing"
    ) unless recipient.empty?
  end

  def closed_case_email(updated_case)
    @case = updated_case
    recipient = []

    @case.case_users.each do |cu|
      if cu.user.closed_case && (cu.user.notification_method == 'email' || cu.user.notification_method == 'both')
        recipient.push(cu.user.email)
      end
    end

    if @case.requested_by.closed_case && (@case.requested_by.notification_method == 'email' || @case.requested_by.notification_method == 'both')
      recipient.push(@case.requested_by.email)
    end

    if @case.assigned_to.closed_case && (@case.assigned_to.notification_method == 'email' || @case.assigned_to.notification_method == 'both')
      recipient.push(@case.assigned_to.email)
    end

    mail(
      to: recipient.uniq,
      subject: "Case No. #{@case.id} is now closed."
    ) unless recipient.empty?
  end
end
