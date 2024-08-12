class CasesController < ApplicationController

  def index
    @open_cases = Case.where.not(status: [3,4]).order( created_at: :desc)
  end

  def billable
    @billable_cases = Case.where(status: 4).order( updated_at: :desc)
  end

  def closed
    @closed_cases = Case.where(status: 3).order( updated_at: :desc)
  end

  def show
    @case = Case.find(params[:id])
  end

  def new
    @case = Case.new
  end

  def edit
    @case = Case.find(params[:id])
  end

  def create
    @case = Case.new(case_params)
    if @case.save
      CaseMailer.new_case_email(@case).deliver_later
      redirect_to @case
    else
      render 'new'
    end
    #@case.notify_assigned_user
  end

  def update
    @case = Case.find(params[:id])

    if @case.update(case_params)
      CaseMailer.update_case_email(@case).deliver_later
      redirect_to @case
    else
      render 'edit'
    end
    # Send text to assigned_user when updating case
    # @case.notify_assigned_user
  end

  def destroy
    @case = Case.find(params[:id])
    @case.destroy()

    respond_to do |format|
      format.html { redirect_to cases_path, status: :see_other, notice: "Case was successfully destroyed." }
      format.json { head :no_content }

    end
  end

  def change_status_to_closed
    @case = Case.find(params[:id])
    if @case.update_attribute(:status_id,3)
      CaseMailer.closed_case_email(@case).deliver_later
      redirect_to cases_path
    else
      render 'edit'
    end
  end

  def change_status_to_complete_billable
    @case = Case.find(params[:id])
    if @case.update_attribute(:status_id,4)
      CaseMailer.billable_case_email(@case).deliver_later
      redirect_to cases_path
    else
      render 'edit'
    end

  end



  private
    def case_params
      params.require(:case).permit(:subject, :status_id, :requested_by_id, :assigned_to_id, :description, :severity_id, :location_ids => [], :user_ids => [], files: [])
    end
end
