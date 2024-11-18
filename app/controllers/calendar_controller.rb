class CalendarController < ApplicationController
  skip_before_action :authenticate_user!, only: [:labor_hours, :labor_hours_report]

  def index
    # Default to beginning and end of the current month if no date range is provided
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
    @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today.end_of_month
  
    # Filter case comments by the selected date range
    @case_comments = CaseComment.where(created_at: @start_date..@end_date)
    @case_comments ||= []
  
    # Sum labor hours for each user within the date range
    @labor_hours = {}
  
    @case_comments.group_by(&:user_id).each do |user_id, comments|
      total_hours = comments.sum { |comment| comment.labor_hours.to_i } # Convert nil to 0
      @labor_hours[user_id] = total_hours
    end
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
  
    # Fetch labor hours for the specified date
    labor_hours_data = CaseComment.where(created_at: parsed_date.all_day).group_by(&:user_id).map do |user_id, comments|
      user = User.find_by(id: user_id)
      next unless user # Skip if user is not found
  
      {
        worker_name: user.first_name,
        total_hours: comments.sum { |comment| comment.labor_hours.to_i } # Handle nil labor_hours
      }
    end.compact # Remove nil entries
  
    render json: labor_hours_data
  rescue => e
    Rails.logger.error "Error in labor_hours: #{e.message}"
    render json: { error: "Internal server error" }, status: :internal_server_error
  end
  
  
  def labor_hours_report
    start_date = params[:start_date]
    end_date = params[:end_date]
  
    # Group by user_id, sum the labor hours, and filter by date range
    @labor_hours_by_user = CaseComment
    .where(created_at: start_date..end_date)
    .joins(:user) # Assuming CaseComment has a relationship with User
    .group(:user_id)
    .sum(:labor_hours)
    .map { |user_id, total_hours| 
      user = User.find(user_id)
      { full_name: user.full_name, total_hours: total_hours } 
    }
  
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
