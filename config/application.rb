require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kisichallenge
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Set job adapter to google pub/sub
    config.active_job.queue_adapter = :pub_sub

    # Needed to autoload google pub/sub adapter which is in /lib
    config.autoload_paths << "#{Rails.root}/lib"
  end
end
