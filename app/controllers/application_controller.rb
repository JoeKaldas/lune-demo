class ApplicationController < ActionController::Base
  before_action :turbo_frame_request_variant

  def turbo_stream_flash_messages
    turbo_stream.replace("flash-messages", partial: "shared/flash")
  end
  helper_method :turbo_stream_flash_messages

  def redirect_to(url, options = {})
    respond_to do |format|
      # HTML explicitly first, so that JS is not the first - that would cause a whole
      # lotta InvalidCrossOrigin errors when called with "Accept: */*"
      format.html { super }
      format.turbo_stream { super }
      format.js { render js: "window.location.href = '#{url}'" }

      # Catch-all
      format.any { super }
    end
  end

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end
