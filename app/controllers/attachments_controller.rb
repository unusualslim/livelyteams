class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def purge
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge
    redirect_back fallback_location: root_path, status: :see_other
  end
end
