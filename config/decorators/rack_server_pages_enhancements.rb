module RackServerPageEnhancer
  class << self
    def init(app, config)
      @@app     = app
      @@app_env = app.env

      config.helpers do
        def partial(file, locals = {}, &block)
          *path, f = file.split '/'
          path << "_#{f}.erb"

          super("app/views/#{path.join('/')}", locals, &block)
        end
      end
    end
  end
end
