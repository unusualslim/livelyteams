class PagesController < ApplicationController


  def index
  end

  def show
    render params[:page]
  end

  def search
  @cases    = Case.ransack(subject_cont: params[:q]).result(distinct: true)
  @locations = Location.ransack(name_cont: params[:q]).result(distinct: true)

  respond_to do |format|
    format.html {}
    format.json {
      @cases    = @cases.limit(5)
      @locations = @locations.limit(5)
    }
  end
end

end
