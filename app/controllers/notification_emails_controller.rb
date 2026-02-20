class NotificationEmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :authorize_owner_or_internal!

  def create
    notification_email = @user.notification_emails.new(notification_email_params)

    if notification_email.save
      redirect_back fallback_location: edit_user_registration_path,
                    notice: "Notification email added."
    else
      redirect_back fallback_location: edit_user_registration_path,
                    alert: notification_email.errors.full_messages.to_sentence
    end
  end

  def update
    notification_email = @user.notification_emails.find(params[:id])

    if notification_email.update(notification_email_update_params)
      redirect_back fallback_location: edit_user_registration_path,
                    notice: "Notification email updated."
    else
      redirect_back fallback_location: edit_user_registration_path,
                    alert: notification_email.errors.full_messages.to_sentence
    end
  end

  def destroy
    notification_email = @user.notification_emails.find(params[:id])
    notification_email.destroy

    redirect_back fallback_location: edit_user_registration_path,
                  notice: "Notification email removed."
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def authorize_owner_or_internal!
    return if current_user == @user
    return if current_user.internal?
    head :forbidden
  end

  def notification_email_params
    params.require(:notification_email).permit(:email)
  end

  def notification_email_update_params
    params.require(:notification_email).permit(:active)
  end
end