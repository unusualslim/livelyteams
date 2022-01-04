class LocationsController < ApplicationController
  def index
    @locations = Location.order(:name).all
  end
 
  def show
    @location = Location.find(params[:id])
    @location_cases = Case.where(location_id: @location.id)
#    @location_cases = Case.where(:location => @location.id)
  end
 
  def new
    @location = Location.new
  end
 
  def edit
    @location = Location.find(params[:id])
  end
 
  def create
    @location = Location.new(location_params)
 
    if @location.save
      redirect_to @location
    else
      render 'new'
    end
  end
 
  def update
    @location = Location.find(params[:id])
 
    if @location.update(location_params)
      redirect_to @location
    else
      render 'edit'
    end
  end
 
  def destroy
    @location = Location.find(params[:id])
    @location.destroy
 
    redirect_to locations_path
  end
 
  private
    def location_params
      params.require(:location).permit(:name, :short_name, :address1, :address2, :city, :state, :zip, :phone, :note)
    end

end
