# Don't enable this in development, or you'll have to re-login every time you switch the user agent, which
# will also break lighthouse runs!
Rails.application.config.middleware.use Rack::Protection::SessionHijacking unless Rails.env.development?
Rails.application.config.middleware.use Rack::Protection::RemoteToken unless Rails.env.test?
