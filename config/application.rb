require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QanzSocialclub
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_mailer.default_url_options = { host: 'localhost:3000' }

    default_mailing_url = 'localhost:3000'
    if Rails.env.staging?
      default_mailing_url = 'http://socialclub-staging.herokuapp.com'
    elsif Rails.env.production?
      default_mailing_url = 'http://socialclub-production.herokuapp.com'
    end
    config.action_mailer.default_url_options = { host: default_mailing_url }
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Melbourne'
    config.assets.enabled = true    
    config.serve_static_assets = true


    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
