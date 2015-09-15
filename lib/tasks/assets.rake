require_relative '../../config/application'

require_relative '../../config/decorators/assets.rb'

namespace :assets do
  task precompile: [ :compile_js ]

  task :compile_js do
    # TODO: JSHint

    asset     = Sprocketfier::Middleware.sprockets['application.js']

    outpath   = "public/assets/javascripts"
    outfile   = Pathname.new(outpath).join("application-#{asset.digest}.min.js")

    FileUtils.mkdir_p outpath

    asset.write_to(outfile)
    asset.write_to("#{outfile}.gz")

    puts "Successfully compiled JS assets"
  end
end
