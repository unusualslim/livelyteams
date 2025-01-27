class PagesController < ApplicationController


  def index
  end

  def show
    render params[:page]
  end

  def search
    # Search for cases by subject or description
    @cases = Case.ransack({
      combinator: 'or',
      groupings: [
        { subject_cont: params[:q] },
        { description_cont: params[:q] }
      ]
    }).result(distinct: true)
  
    # Search for locations by name
    @locations = Location.ransack(name_cont: params[:q]).result(distinct: true)
  
    # Search for comments directly
    @comments = CaseComment.ransack(body_cont: params[:q]).result(distinct: true)
  
    respond_to do |format|
      format.html {}
      format.json {
        @cases = @cases.limit(5)
        @locations = @locations.limit(5)
        @comments = @comments.limit(5)
      }
    end
  end  
end
