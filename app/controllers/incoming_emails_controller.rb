class IncomingEmailsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    # before_action :skip_authentication, only: [:create]
  
    def create
      sender = params[:from].match(/<([^>]+)>/)&.captures&.first
      puts "Sender is: #{sender}"
      subject = params['subject']
      body = params['text']
      text = "#{body} - Sent by #{sender}"
      to = params['to']
      attachment_info = params["attachment-info"]
      if attachment_info.present?
        attachment_info = JSON.parse(attachment_info)
        filename = attachment_info["attachment1"]["filename"]
        type = attachment_info["attachment1"]["type"]
        attachment = params["attachment1"]
      else
        # Handle the case where attachment-info is nil
        logger.warn("No attachment information found in params")
      end

      if to =~ /support@livelyteams\.com/
          @case = Case.new(
            subject: subject,
            description: text,
            status_id: 1,
            severity_id: 2,
            location_ids: 152,
            assigned_to_id: 79,
          )
        #check if sender of email corresponds to a user
        user = User.find_by(email: sender)
        @case.requested_by_id = user || 79
        
        # Attach files to the case if available
        if attachment.present?
          puts "Attachment present. Attaching to case..."
          @case.files.attach(io: attachment.tempfile, filename: filename, content_type: type)
          puts "Attachment attached to case."
        else
          puts "No attachment present."
        end
    
        if @case.save
          head :ok
        else
          puts "Error saving case: #{@case.errors.full_messages}"
          head :unprocessable_entity
        end
      else
        puts "Email was not sent to 'support@livelyteams.com'"
      end
    end

    private

    def save_attachments(attachments)
      attachments.each do |attachment_data|
        # Create ActiveStorage attachment from attachment data
        @case.files.attach(io: StringIO.new(attachment_data['data']), filename: attachment_data['filename'])
      end
    end

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