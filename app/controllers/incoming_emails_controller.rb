class IncomingEmailsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    whitelist = ['support@livelyteams.com']
    # before_action :skip_authentication, only: [:create]
  
    def create
      # Log request parameters
      puts "Incoming email request parameters: #{params.inspect}"
  
      sender = params['from']
      subject = params['subject']
      body = params['text']
      to = params['to']
      # validates to, presence: true, blob: {content_type: whitelist}
      puts "Sent to this email: #{to}"
      puts "Sender(from): #{sender}"
      puts "Subject is: #{subject}"
      puts "Body is: #{body}"

      @case = Case.new(
        subject: subject,
        description: body,
        status_id: 1,
        severity_id: 2,
        location_ids: 152,
        assigned_to_id: 79,
        requested_by_id: 79,
      )
  
      if @case.save
        head :ok
      else
        puts "Error saving case: #{@case.errors.full_messages}"
        head :unprocessable_entity
      end
  
      # Rails.logger.info "Received email from: #{sender}"
      # Rails.logger.info "Received email with subject: #{subject}"
      # Rails.logger.info "Email body: #{body}"

    end

    private

    def skip_authentication
      if request_from_email_client?
        puts "Skipping authentication for email client request."
        skip_authentication!
      else
        puts "Not skipping authentication."
      end
    end

    def request_from_email_client?
      params.key?('from') && params.key?('subject') && params.key?('text')
    end
  end