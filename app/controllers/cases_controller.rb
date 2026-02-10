class CasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_case, only: %i[
    show edit update destroy
    change_status_to_closed change_status_to_complete_billable change_status_to_inspectable
    send_to_ap
  ]
  before_action :authorize_case_access!, only: %i[
    show edit update destroy
    change_status_to_closed change_status_to_complete_billable change_status_to_inspectable
    send_to_ap
  ]

  def index
    @users = User.all
    base = case_scope

    @open_cases = base
      .where.not(status_id: [3, 4])
      .order(created_at: :desc)

    @open_cases_counts = base
      .where(status_id: [1]) # 1 = "open"
      .group(:assigned_to_id)
      .count
  end

  def billable
    base = case_scope
    @billable_cases = base.where(status_id: 4).order(updated_at: :desc)
  end

  def closed
    base = case_scope
    @closed_cases = base.where(status_id: 3).order(updated_at: :desc)
  end

  def inspectable
    base = case_scope
    @inspectable_cases = base.where(status_id: 5).order(updated_at: :desc)
  end

  def show
    # @case is set by set_case
  end

  def new
    @case = Case.new
  end

  def edit
    # @case is set by set_case
  end

  def create
    @case = Case.new(case_params)

    if @case.save
      CaseMailer.new_case_email(@case).deliver_later
      redirect_to @case
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @case.update(case_params)
      CaseMailer.update_case_email(@case).deliver_later
      redirect_to @case
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @case.destroy

    respond_to do |format|
      format.html { redirect_to cases_path, status: :see_other, notice: "Case was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def change_status_to_closed
    if @case.update(status_id: 3)
      CaseMailer.closed_case_email(@case).deliver_later
      redirect_to cases_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def change_status_to_complete_billable
    if @case.update(status_id: 4)
      CaseMailer.billable_case_email(@case).deliver_later
      redirect_to cases_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def change_status_to_inspectable
    if @case.update(status_id: 5)
      CaseMailer.inspectable_case_email(@case).deliver_later
      redirect_to cases_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def send_to_ap
    file = @case.files.find(params[:file_id])
    CaseMailer.send_to_ap(file).deliver_now
    redirect_to case_path(@case), notice: "Photo sent to AP successfully!"
  end

  private

  def set_case
    @case = Case.find(params[:id])
  end

  def authorize_case_access!
    return if current_user.internal?

    allowed =
      @case.requested_by_id == current_user.id ||
      @case.assigned_to_id == current_user.id ||
      @case.users.exists?(id: current_user.id)

    redirect_to cases_path, alert: "You don’t have access to that case." unless allowed
  end

  def case_scope
    if current_user.internal?
      Case.all
    else
      Case
        .left_joins(:case_users)
        .where(
          "case_users.user_id = :uid OR cases.requested_by_id = :uid OR cases.assigned_to_id = :uid",
          uid: current_user.id
        )
        .distinct
    end
  end

  def case_params
    params.require(:case).permit(
      :subject, :status_id, :requested_by_id, :assigned_to_id, :description, :severity_id,
      location_ids: [], user_ids: [], files: []
    )
  end
end
