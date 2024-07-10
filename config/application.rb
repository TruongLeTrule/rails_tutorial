require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module RailsTutorial
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :vi
    config.email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    config.max_email_length = 255
    config.max_name_length = 50
    config.min_password_length = 6
  end
end
