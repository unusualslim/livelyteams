class TwilioService
  def initialize
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def send_sms(user, message)
    phone_number = user.phone_number

    if user.notification_method == 'text' || user.notification_method == 'both'
      @client.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: phone_number,
        body: message
      )
    else
      Rails.logger.info "User #{user.id} has not opted in for SMS notifications."
    end
  end
end