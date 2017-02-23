require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'BluelinerTippspiel'
  end

  test 'should get home' do
    get static_pages_home_url
    assert_response :success
    assert_select 'title', "Home | #{@base_title}"
  end

  test 'should get help' do
    get static_pages_help_url
    assert_response :success
    assert_select 'title', "Hilfe | #{@base_title}"
  end

  test 'should get rules' do
    get static_pages_rules_url
    assert_response :success
    assert_select 'title', "Regeln | #{@base_title}"
  end
end
