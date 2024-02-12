class IncomingEmailsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def create
      # Log request parameters
      Rails.logger.info "Incoming email request parameters: #{params.inspect}"
  
      # Parse request body if it's JSON
      email_data = JSON.parse(request.body.read)
  
      # Log parsed email data
      Rails.logger.info "Parsed email data: #{email_data.inspect}"
  
      sender = email_data['from']
      subject = email_data['subject']
      body = email_data['text']
      Rails.logger.info "Received email from: #{sender}"
      Rails.logger.info "Received email with subject: #{subject}"
      Rails.logger.info "Email body: #{body}"
  
      # Case.create(sender: sender, subject: subject, body: body)
  
      head :ok
    end
  end