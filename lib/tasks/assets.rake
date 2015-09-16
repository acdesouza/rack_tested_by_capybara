require_relative '../../config/application'

require_relative '../../config/decorators/assets.rb'

namespace :assets do
  task precompile: [ :compile_js, :compile_css ]

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

  task :compile_css do
    asset     = Sprocketfier::Middleware.sprockets['application.css']

    outpath   = "public/assets/stylesheets"
    outfile   = Pathname.new(outpath).join("application-#{asset.digest}.min.css")

    FileUtils.mkdir_p outpath

    asset.write_to(outfile)
    asset.write_to("#{outfile}.gz")

    puts "Successfully compiled CSS assets"
  end
end
