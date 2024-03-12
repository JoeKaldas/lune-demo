# Allow trying to localize nil dates
#

# Load dry-validation's i18n support first, so we can override if we want
require "dry/schema/messages/i18n"
require "i18n"


I18n.backend.load_translations

module I18n
  class << self
    alias original_localize localize

    def localize(object, options = {})
      object.present? ? original_localize(object, **options) : nil
    end
  end
end
