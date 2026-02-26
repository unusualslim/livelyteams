class IncomingEmailsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  DEFAULT_REQUESTED_BY_ID = 79
  DEFAULT_ASSIGNED_TO_ID  = 79
  DEFAULT_LOCATION_ID     = 152

  def create
    sender  = extract_sender_email(params[:from])
    subject = params['subject'].to_s
    body    = params['text'].to_s
    to      = params['to'].to_s

    text = "#{body} - Sent by #{sender.presence || 'unknown sender'}"

    attachment, filename, content_type = extract_first_attachment(params)

    requested_by_id = User.find_by(email: sender)&.id || DEFAULT_REQUESTED_BY_ID

    unless to.match?(/support@livelyteams\.com/i)
      Rails.logger.info("Incoming email ignored (not to support@livelyteams.com). to=#{to}")
      return head :ok
    end

    @case = Case.new(
      subject: subject.presence || "(No subject)",
      description: text,
      status_id: 1,
      severity_id: 2,
      location_ids: DEFAULT_LOCATION_ID,
      requested_by_id: requested_by_id,
      assigned_to_id: DEFAULT_ASSIGNED_TO_ID
    )

    if attachment.present?
      Rails.logger.info("Attachment present. Attaching to case... filename=#{filename} content_type=#{content_type}")
      @case.files.attach(
        io: attachment.tempfile,
        filename: filename.presence || "attachment",
        content_type: content_type.presence || "application/octet-stream"
      )
    end

    if @case.save
      CaseMailer.new_case_email(@case).deliver_later
      TwilioService.new.send_sms(
        User.find(59),
        "New unassigned case on livelyteams:  https://livelyteams.com/cases/#{@case.id}"
      )
      head :ok
    else
      Rails.logger.error("Error saving case: #{@case.errors.full_messages.join(', ')}")
      head :unprocessable_entity
    end
  end

  private

  def extract_sender_email(from_value)
    from = from_value.to_s.strip
    return "" if from.blank?

    email =
      from.match(/<([^>]+)>/)&.captures&.first ||
      from.match(/([A-Z0-9._%+\-]+@[A-Z0-9.\-]+\.[A-Z]{2,})/i)&.captures&.first

    email.to_s.downcase.strip
  end

  def extract_first_attachment(p)
    info_raw = p["attachment-info"]
    return [nil, nil, nil] if info_raw.blank?

    info = JSON.parse(info_raw) rescue nil
    return [nil, nil, nil] if info.blank?

    first_key = info.keys.sort.first
    meta = info[first_key] || {}

    file_param = p[first_key]
    return [nil, nil, nil] unless file_param.present?

    [file_param, meta["filename"], meta["type"]]
  end
end