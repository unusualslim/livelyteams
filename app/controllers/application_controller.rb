class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :phone_number, :email, :password, :picture)}

       devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :phone_number, :email, :password, :picture, :current_password)}
    end
#  before_action :establish_team
 
#  helper_method :current_team

#  def establish_team
#      return session[:current_team] unless session[:current_team].nil?
#        session[:current_team] = current_user.teams.first.id 
  
  #   session[:current_team] = current_user.teams.first.id
#  end

#  def current_team
#    @_team ||= Team.find(session[:current_team])
#  end 

end
