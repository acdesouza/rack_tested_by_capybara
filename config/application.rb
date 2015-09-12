require_relative 'boot'

module RackAppWithCapybara
  class << self

    @@initializers = []

    def register_to_init(initializer)
      @@initializers << initializer
    end

    def application
      @app ||= Rack::Builder.new do |builder|
        use Rack::ServerPages do |config|
          config.view_path = 'app/views'

          @@initializers.each do |initializer|
            initializer.init(RackAppWithCapybara.env, config)
          end
        end

        @@initializers.each do |initializer|
          initializer.middleware(builder)
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

    def groups
      env = RackAppWithCapybara.env
      groups = [:default, env]
    end
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*RackAppWithCapybara.groups)

Dir["./config/initializers/*.rb"].each do |initializer|
  require initializer
end
