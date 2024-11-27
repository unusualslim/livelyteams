class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :configure_preferences_update_params, only: [:update_preferences]

  def create
    Rails.logger.info "Create action invoked with params: #{params.inspect}"
    super
  end

  def update
    if update_resource(resource, account_update_params)
      set_flash_message :notice, :updated
      sign_in resource, bypass: true if sign_in_after_change_password?
      respond_with resource, location: after_update_path_for(resource)
    else
      respond_with resource
    end
  end
  
  def update_resource(resource, params)
    if params[:password].present? || params[:password_confirmation].present? || params[:current_password].present?
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end
  end

  def update_preferences
    @user = resource_class.find(current_user.id)
    
    if @user.update(preferences_update_params)
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def configure_sign_up_params
    Rails.logger.info "Configuring sign-up parameters"
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number])
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :current_password)
  end

  private

  def check_captcha
    recaptcha_enabled = true # Set to true to reenable

    return if !recaptcha_enabled || verify_recaptcha

    self.resource = resource_class.new sign_up_params
    resource.validate # Look for any other validation errors besides reCAPTCHA
    set_minimum_password_length

    respond_with_navigational(resource) do
      flash.discard(:recaptcha_error) # Discard flash to avoid showing it on the next page reload
      render :new
    end
  end

  protected

  def configure_preferences_update_params
    devise_parameter_sanitizer.permit(:update_preferences, keys: [
      :new_case_created, :updated_case, :new_comment, :billable_case, :closed_case, :notification_method
    ])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name, :phone_number, :password, :password_confirmation, :current_password,
      :new_case_created, :updated_case, :new_comment, :billable_case, :closed_case, :notification_method
    ])
  end

  def preferences_update_params
    params.require(:user).permit(:new_case_created, :updated_case, :new_comment, :billable_case, :closed_case, :notification_method)
  end

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