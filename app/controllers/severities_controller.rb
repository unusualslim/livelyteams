class SeveritiesController < ApplicationController
  def index
    @severities = Severity.all
  end
 
  def show
    @severity = Severity.find(params[:id])
  end
 
  def new
    @severity = Severity.new
  end
 
  def edit
    @severity = Severity.find(params[:id])
  end
 
  def create
    @severity = Severity.new(severity_params)
 
    if @severity.save
      redirect_to @severity
    else
      render 'new'
    end
  end
 
  def update
    @severity = Severity.find(params[:id])
 
    if @severity.update(severity_params)
      redirect_to @severity
    else
      render 'edit'
    end
  end
 
  def destroy
    @severity = Severity.find(params[:id])
    @severity.destroy
 
    redirect_to severities_path
  end
 
  private
    def severity_params
      params.require(:severity).permit(:severity, :description)
    end

end
