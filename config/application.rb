require_relative 'boot'

class RackAppWithCapybara
  def self.application
    @app = proc do |env|
      [ 200, {'Content-Type' => 'text/plain'}, ["It works!"] ]
    end

    @app
  end
end
