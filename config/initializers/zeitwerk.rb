# These paths cannot be on autoload as we use them as namespaces
# https://guides.rubyonrails.org/classic_to_zeitwerk_howto.html#having-app-in-the-autoload-paths
 ActiveSupport::Dependencies.autoload_paths.delete("#{Rails.root}/app/models/concerns")
 ActiveSupport::Dependencies.autoload_paths.delete("#{Rails.root}/app/forms")
 ActiveSupport::Dependencies.autoload_paths.delete("#{Rails.root}/app/forms/concerns")
