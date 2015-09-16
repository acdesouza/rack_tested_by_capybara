require_relative 'boot'

module RackAppWithCapybara
  class << self

    @@initializers = []

    def register_to_init(initializer)
      @@initializers << initializer
    end

    def application
      @app ||= Rack::Builder.new do |builder|
        use Rack::CommonLogger, RackAppWithCapybara.logger unless RackAppWithCapybara.env.test?

        use Rack::ServerPages do |config|
          config.view_path = 'app/views'

          @@initializers.each do |initializer|
            initializer.init(RackAppWithCapybara, config)
          end
        end

        @@initializers.each do |initializer|
          initializer.middleware(RackAppWithCapybara, builder) if initializer.respond_to? :middleware
        end

        run Rack::ServerPages::NotFound
      end.to_app

      @app
    end

    def env
      rack_env = ENV['RACK_ENV'] ? ENV['RACK_ENV'].strip : "development"

      def rack_env.method_missing(name, *args, &block)
        false
      end

      if !rack_env.empty?
        rack_env.define_singleton_method("#{rack_env}?") { true }
      end

      rack_env
    end

    def logger
      @@app_logger ||= Logger.new(STDOUT)
      @@app_logger.level = self.log_level

      @@app_logger
    end

    def log_level
      level_config = {
        production: Logger::WARN,
        test: Logger::WARN
      }
      if level_config.include?(self.env.to_sym)
        level_config[self.env.to_sym]
      else
        Logger::DEBUG
      end
    end

    def groups
      env = RackAppWithCapybara.env
      groups = [:default, :assets, env]
    end
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*RackAppWithCapybara.groups)

Dir["./config/decorators/*.rb"].each do |decorator|
  require decorator
end

Dir["./config/initializers/*.rb"].each do |initializer|
  require initializer
end
