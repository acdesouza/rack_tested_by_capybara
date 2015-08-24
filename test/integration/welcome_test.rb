# -*- coding: utf-8 -*-

require 'test_helper'

class WelcomeTest < IntegrationTest
  def test_should_works
    visit '/'
    assert page.has_content?('It works!')
  end

  def test_should_greet_with_welcome
    visit '/welcome'
    assert page.has_content?('Welcome!')
  end

  def test_should_return_404
    visit '/not_existing'
    assert_equal 404, page.status_code
  end
end

