class ApplicationController < ActionController::Base
  before_action :turbo_frame_request_variant

  def turbo_stream_flash_messages
    turbo_stream.replace("flash-messages", partial: "shared/flash")
  end
  helper_method :turbo_stream_flash_messages

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end
