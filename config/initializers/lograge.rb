# frozen_string_literal: true

Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.colorize_logging = false
  config.lograge.base_controller_class = 'ActionController::API'

  config.lograge.custom_options = lambda do |event|
    {
      params: event.payload[:params]
    }
  end
end
