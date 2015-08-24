require_relative 'boot'

class RackAppWithCapybara
  def self.application
    @app = proc do |env|
      case env['PATH_INFO']
      when "/"
        [ 200, {'Content-Type' => 'text/plain'}, ["It works!"] ]
      else
        [ 404, {'Content-Type' => 'text/plain'}, ["This is not the page you're looking for..."] ]
      end
    end

    @app
  end
end
