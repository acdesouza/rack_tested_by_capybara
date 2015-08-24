gem "minitest" # Make sure we get the gem, not stdlib
require "minitest"
require "minitest/autorun"

require 'capybara'
require 'capybara/dsl'

class IntegrationTest < Minitest::Test
  include ::Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

