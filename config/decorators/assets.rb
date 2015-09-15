module Sprocketfier
  class << self
    def init(env, config)
      @@app_env = env
      config.helpers do
        def javascript_include_tag(js = 'application', options = {})
          if @@app_env.production?
            asset = Sprocketfier::Middleware.sprockets["#{js}.js"]
            href = "/assets/javascripts/#{js}-#{asset.digest}.min.js"
          else
            href = "/assets/#{js}.js?"
          end

          %Q{<script src="#{href}" type="text/javascript"></script> }
        end
      end
    end

    def middleware(env, builder)
      public_urls = [ "/images", "/javascripts" ]
      public_urls << "/assets" if env.production?
      builder.use Rack::Static, urls: public_urls, root: "public"

      builder.map '/assets' do
        run Sprocketfier::Middleware.sprockets
      end
    end
  end

  class Middleware
    def self.sprockets
      Sprockets::Environment.new.tap do |environment|
        environment.append_path 'app/assets/javascripts'
      end
    end
  end
end
