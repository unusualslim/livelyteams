class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, only: %i[show edit update destroy]
  before_action :authorize_location_access!, only: %i[show edit update destroy]

  def index
    @locations = location_scope.order(:name)
  end

  def show
    # Use association (covers case_locations join)
    @location_cases =
      if current_user.internal?
        @location.cases.order(created_at: :desc)
      else
        # External: only cases at this location they can actually access
        case_scope.where(id: @location.case_locations.select(:case_id)).order(created_at: :desc)
      end
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to @location
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @location.update(location_params)
      redirect_to @location
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_path, status: :see_other
  end

  def search
    @locations = location_scope.ransack(name_cont: params[:q]).result(distinct: true).limit(5)

    respond_to do |format|
      format.json
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def authorize_location_access!
    return if current_user.internal?

    allowed = location_scope.where(id: @location.id).exists?
    redirect_to locations_path, alert: "You don’t have access to that location." unless allowed
  end

  # Same “who can see what” rule as CasesController
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

  # External locations = locations tied to cases they can access
  def location_scope
    if current_user.internal?
      Location.all
    else
      Location
        .joins(:cases)
        .merge(case_scope)
        .distinct
    end
  end

  def location_params
    params.require(:location).permit(:name, :short_name, :address1, :address2, :city, :state, :zip, :phone, :status)
  end
end
