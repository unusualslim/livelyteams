class TaskMailer < ApplicationMailer
  default from: 'no-reply@livelyteams.com'

  def new_task_email(task)
    @task = task

    recipients = [
      *@task.requested_by.notification_recipients,
      *@task.assigned_to.notification_recipients
    ].compact.uniq

    mail(to: recipients, subject: 'You have created a new task')
  end

  def update_task_email(task)
    @task = task

    recipients = [
      *@task.requested_by.notification_recipients,
      *@task.assigned_to.notification_recipients
    ].compact.uniq

    mail(to: recipients, subject: 'Your task has been Updated')
  end
end