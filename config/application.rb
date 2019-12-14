require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TaobaoCrawl
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.active_job.queue_adapter = :sidekiq

    config.autoload_paths += %W(#{config.root}/lib/)
    config.autoload_paths += %W(#{config.root}/lib/tao_bao_api/)
    config.time_zone = 'Beijing'
    config.i18n.default_locale = :'zh-CN'
    config.i18n.available_locales = [:'zh-CN', :en]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    Sidekiq.configure_server do |config|
      schedule_file = "config/schedule.yml"

      if File.exist?(schedule_file)
        Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
      end
    end
  end
end
