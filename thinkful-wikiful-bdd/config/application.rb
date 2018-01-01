require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ThinkfulWikifulBdd
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Make sure we can find our theme in our custom directory.
    initializer :after_append_asset_paths,
                :group => :all,
                :after => :append_assets_path do
        config.assets.paths.unshift Rails.root.join("vendor", "assets", "stylesheets", "jquery-ui", "theme").to_s
        config.assets.paths.unshift Rails.root.join("vendor", "assets", "javascripts", "jquery-ui", "theme").to_s
        config.assets.paths.unshift Rails.root.join("vendor", "assets", "images").to_s
    end
  end
end
