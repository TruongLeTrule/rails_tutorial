require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module RailsTutorial
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = %i(en vi)
    config.i18n.default_locale = :vi
    config.active_storage.variant_processor = :mini_magick
    config.middleware.use I18n::JS::Middleware
  end
end
