require_relative 'boot'

module RackAppWithCapybara
  class << self
    @app = nil

    def application
      @app ||= Rack::Builder.new do
        use Rack::ServerPages do |config|
          config.view_path = 'app/views'
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
