require 'config/application'
require 'integration_test'

require 'capybara/poltergeist'
Capybara.configure do |config|
  config.app = RackAppWithCapybara.application
  config.default_driver    = :poltergeist
  config.javascript_driver = :poltergeist
end

