class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create] # Adjust as needed
  before_action :configure_sign_up_params, only: [:create]

  def create
    Rails.logger.info "Create action invoked with params: #{params.inspect}"
    super
  end

  def update
    if resource.update(resource_params)
      respond_to do |format|
        format.html { redirect_to after_update_path_for(resource), notice: 'Preferences updated successfully' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('user_form', html: render_to_string(template: 'users/registrations/edit'))
        end
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('user_form', partial: 'users/registrations/edit', locals: { resource: resource }) }
      end
    end
  end
  
  def update_resource(resource, params)
    if params[:notification_method] || params[:new_case_created] || params[:updated_case] || params[:new_comment] || params[:billable_case] || params[:closed_case]
      resource.update_without_password(params)
    else
      super
    end
  end

  private

  def check_captcha
    return if verify_recaptcha # verify_recaptcha(action: 'signup') for v3

    self.resource = resource_class.new sign_up_params
    resource.validate # Look for any other validation errors besides reCAPTCHA
    set_minimum_password_length

    respond_with_navigational(resource) do
      flash.discard(:recaptcha_error) # Discard flash to avoid showing it on the next page reload
      render :new
    end
  end

  protected

  def resource_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :phone_number,
      :email,
      :password,
      :password_confirmation,
      :current_password,
      :new_case_created,
      :updated_case,
      :new_comment,
      :billable_case,
      :closed_case,
      :notification_method
    )
  end
end