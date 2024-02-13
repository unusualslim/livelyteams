class IncomingEmailsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :skip_authentication, only: [:create]
  
    def create
      # Log request parameters
      Rails.logger.info "Incoming email request parameters: #{params.inspect}"
  
      # Parse request body if it's JSON
      parameters = params.to_unsafe_hash
      sender = parameters['from']
      subject = parameters['subject']
      body = parameters['text']

      @case = Case.new(
        subject: subject,
        description: body,
        
        location_id: 152,
        assigned_to_id: 79
      )
  
      if @case.save
        head :ok
      else
        head :unprocessable_entity
      end
  
      # Rails.logger.info "Received email from: #{sender}"
      # Rails.logger.info "Received email with subject: #{subject}"
      # Rails.logger.info "Email body: #{body}"

    end

    private

    def skip_authentication
      if request_from_email_client?
        skip_authentication!
      end
    end

    def request_from_email_client?
      request.headers['User-Agent'].to_s.downcase.include?('email-client')
    end
  end