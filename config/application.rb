require_relative 'boot'
require 'rack-server-pages'

class RackAppWithCapybara
  def self.application
    @app = Rack::Builder.new do
      use Rack::ServerPages do |config|
        config.view_path = 'app/views'
      end

      run Rack::ServerPages::NotFound
    end.to_app

    @app
  end
end
