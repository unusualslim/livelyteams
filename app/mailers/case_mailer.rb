class CaseMailer < ApplicationMailer
default from: 'no-reply@livelyteams.com'

 def new_case_email(new_case)
   @case = new_case
   recipient = []
   @case.case_users.each do |cu|
     recipient.push(cu.user.email)
   end
   recipient.push(@case.requested_by.email)
   recipient.push(@case.assigned_to.email)

    mail(
       to: recipient.uniq,
       subject: "[#{@case.severity.severity}] Case No. #{@case.id} #{@case.subject}"
     )
 end

 def update_case_email(updated_case)
   @case = updated_case
   recipient = []
   @case.case_users.each do |cu|
     recipient.push(cu.user.email)
   end
   recipient.push(@case.requested_by.email)
   recipient.push(@case.assigned_to.email)

    mail(
       to: recipient.uniq,
       subject: "Case No. #{@case.id} has been updated"
    )
 end

 def new_comment_case_email(updated_case)
   @case = updated_case
   recipient = []
   @case.case_users.each do |cu|
     recipient.push(cu.user.email)
   end
   recipient.push(@case.requested_by.email)
   recipient.push(@case.assigned_to.email)

    mail(
       to: recipient.uniq,
       subject: "Case No. #{@case.id} has a new comment"
    )
 end

 def billable_case_email(updated_case)
   @case = updated_case
   recipient = []
   @case.case_users.each do |cu|
     recipient.push(cu.user.email)
   end
   recipient.push(@case.requested_by.email)
   recipient.push(@case.assigned_to.email)

    mail(
       to: recipient.uniq,
       subject: "Case No. #{@case.id} is complete and ready for billing"
    )
  end

  def closed_case_email(updated_case)
   @case = updated_case
   recipient = []
   @case.case_users.each do |cu|
     recipient.push(cu.user.email)
   end
   recipient.push(@case.requested_by.email)
   recipient.push(@case.assigned_to.email)

    mail(
       to: recipient.uniq,
       subject: "Case No. #{@case.id} is now closed."
    )
  end



end
