require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Ruby2020FindJob
  class Application < Rails::Application
    config.load_defaults 6.0
    
    config.middleware.use I18n::JS::Middleware
    config.i18n.default_locale = :vi
    config.active_job.queue_adapter = :sidekiq
    config.session_store :active_record_store,
      :key => "_redmine_session"
    
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: %i(get post put patch delete options)
      end
    end
  end
end
