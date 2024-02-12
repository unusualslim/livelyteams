class IncomingEmailsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def create
      # Log request parameters
      Rails.logger.info "Incoming email request parameters: #{params.inspect}"
  
      # Parse request body if it's JSON
      parameters = params.to_unsafe_hash
      sender = parameters['from']
      subject = parameters['subject']
      body = parameters['text']
  
      Rails.logger.info "Received email from: #{sender}"
      Rails.logger.info "Received email with subject: #{subject}"
      Rails.logger.info "Email body: #{body}"
  
      # Case.create(sender: sender, subject: subject, body: body)
  
      head :ok
    end
  end