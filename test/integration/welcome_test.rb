# -*- coding: utf-8 -*-

require 'test_helper'

class WelcomeTest < IntegrationTest
  def test_should_works
    visit '/'
    assert page.has_content?('It works!')
  end
end

