class TaskMailer < ApplicationMailer
  default from: 'no-reply@livelyteams.com'

  def new_task_email(task)
    @task = task
    mail(to: [@task.requested_by.email, @task.assigned_to.email],  subject: 'You have created a new task')
  end

  def update_task_email(task)
    @task = task
    mail(to: [@task.requested_by.email, @task.assigned_to.email], subject: 'Your task has been Updated')
  end

end
