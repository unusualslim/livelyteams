class CaseCommentsController < ApplicationController

  def index
    @comments = CaseComment.order("created_at DESC").limit(500)
  end
  def create
    @case = Case.find(params[:case_id])
    @case_comment = @case.case_comments.create(case_comment_params)
      CaseMailer.new_comment_case_email(@case).deliver_later
    # TaskMailer.with(task: @task).update_task_email.deliver_now
    redirect_to case_path(@case)
  end

  private
    def case_comment_params
      params.require(:case_comment).permit(:user_id, :body, :labor_hours)
    end
end
