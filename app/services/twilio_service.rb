class TwilioService
  def initialize
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def send_sms(user, message)
    phone_number = user.phone_number

    if user.notification_method == 'text' || user.notification_method == 'both'
      begin
        @client.messages.create(
          from: ENV['TWILIO_PHONE_NUMBER'],
          to: phone_number,
          body: message
        )
        Rails.logger.info "SMS sent to #{phone_number}"
      rescue Twilio::REST::RestError => e
        # Log the error and handle it gracefully
        Rails.logger.error "Twilio error: #{e.message}"
        handle_sms_error(e, user)
      end
    else
      Rails.logger.info "User #{user.id} has not opted in for SMS notifications."
    end
  end

  private

  def handle_sms_error(error, user)
    Rails.logger.error "Failed to send SMS to User #{user.id}. Error: #{error.message}"
  end
end