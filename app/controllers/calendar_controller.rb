class CalendarController < ApplicationController
  skip_before_action :authenticate_user!, only: [:labor_hours, :labor_hours_report]

  def index
    # Default to beginning and end of the current month if no date range is provided
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
    @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today.end_of_month
  
    @labor_hours = CaseComment
      .where(created_at: @start_date..@end_date)
      .group(:user_id)
      .sum(:labor_hours)
      .transform_values(&:to_i)
  end
  

  def labor_hours
    date = params[:date]
  
    # Ensure the date parameter is present
    if date.blank?
      render json: { error: "Date is required" }, status: :bad_request and return
    end
  
    # Parse the date safely
    begin
      parsed_date = Date.parse(date)
    rescue ArgumentError
      render json: { error: "Invalid date format" }, status: :unprocessable_entity and return
    end
  
    comments = CaseComment.where(created_at: parsed_date.all_day).includes(:user)
    labor_hours_data = comments.group_by(&:user_id).filter_map do |_user_id, user_comments|
      user = user_comments.first.user
      next unless user

      {
        worker_name: user.first_name,
        total_hours: user_comments.sum { |c| c.labor_hours.to_i }
      }
    end
  
    render json: labor_hours_data
  rescue => e
    Rails.logger.error "Error in labor_hours: #{e.message}"
    render json: { error: "Internal server error" }, status: :internal_server_error
  end
  
  
  def labor_hours_report
    start_date = params[:start_date]
    end_date = params[:end_date]
  
    # Group by user_id, sum the labor hours, and filter by date range
    totals = CaseComment
      .where(created_at: start_date..end_date)
      .group(:user_id)
      .sum(:labor_hours)

    users = User.where(id: totals.keys).index_by(&:id)

    @labor_hours_by_user = totals.map do |user_id, total_hours|
      { full_name: users[user_id]&.full_name, total_hours: total_hours.to_i }
    end
  
    # Explicitly respond with HTML (rendering the report on the new page)
    respond_to do |format|
      format.html { render :report }  # Ensure you have a 'report.html.erb' view to render the report
    end
  end
  
  

  private

  def fetch_labor_hours_for_date(date)
    LaborHour.where(date: date).map do |labor_hour|
      { worker_name: labor_hour.worker_name, total_hours: labor_hour.total_hours }
    end
  end
end
