require 'config/application'
require 'integration_test'

Capybara.configure do |config|
  config.app = RackAppWithCapybara.application
end

