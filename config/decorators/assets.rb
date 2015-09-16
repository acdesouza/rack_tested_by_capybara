module Sprocketfier
  class << self
    def init(app, config)
      @@app     = app
      @@app_env = app.env

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

        def stylesheets_link_tag(css = 'application', options = {})
          if @@app_env.production?
            asset = Sprocketfier::Middleware.sprockets["#{css}.css"]
            href = "/assets/stylesheets/#{css}-#{asset.digest}.min.css"
          else
            href = "/assets/#{css}.css?"
          end

          %Q{<link rel="stylesheet" href="#{href}" type="text/css" media="#{options[:media] || 'all'}" />}
        end
      end
    end

    def middleware(app, builder)
      public_urls = [ "/images", "/javascripts", "/stylesheets" ]
      public_urls << "/assets" if app.env.production?
      builder.use Rack::Static, urls: public_urls, root: "public"

      Sprocketfier::Middleware.logger = app.logger
      builder.map '/assets' do
        run Sprocketfier::Middleware.sprockets
      end
    end
  end

  class Middleware
    class << self
      def logger=(logger)
        @@logger = logger
      end

      def logger
        @@logger
      end

      def sprockets
        Sprockets::Environment.new.tap do |environment|
          environment.logger = Middleware.logger

          environment.append_path 'app/assets/javascripts'
          environment.append_path 'app/assets/stylesheets'

          environment.append_path Compass::Core.base_directory("stylesheets")
        end
      end
    end
  end
end
