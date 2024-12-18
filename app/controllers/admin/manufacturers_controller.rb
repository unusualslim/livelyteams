class Admin::ManufacturersController < ApplicationController
   def index
    @manufacturers = Manufacturer.all
   end
 
   def show
     @manufacturer = Manufacturer.find(params[:id])
   end
 
   def new
     @manufacturer = Manufacturer.new
   end
 
   def edit
     @manufacturer = Manufacturer.find(params[:id])
   end
 
   def create
     @manufacturer = Manufacturer.new(manufacturer_params)
 
     if @manufacturer.save
       redirect_to [:admin, @manufacturer]
     else
       render 'new'
     end
   end
 
   def update
    @manufacturer = Manufacturer.find(params[:id])
 
    if @manufacturer.update(manufacturer_params)
      redirect_to [:admin, @manufacturer]
    else
      render 'edit'
    end
   end
 
   def destroy
     @manufacturer = Manufacturer.find(params[:id])
     @manufacturer.destroy
 
     redirect_to admin_manufacturers_path
   end
 
   private
     def manufacturer_params
       params.require(:manufacturer).permit(:name, :team_id)
     end
end

