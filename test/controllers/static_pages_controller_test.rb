require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get root_path
    assert_response :success
    assert_select 'title', 'Blueliner Tippspiel'
  end

  test 'should get help' do
    get help_path
    assert_response :success
    assert_select 'title', 'Hilfe | Blueliner Tippspiel'
  end

  test 'should get rules' do
    get rules_path
    assert_response :success
    assert_select 'title', 'Regeln | Blueliner Tippspiel'
  end

  test 'should get about' do
    get about_path
    assert_response :success
    assert_select 'title', 'Über | Blueliner Tippspiel'
  end

  test 'should get contact' do
    get contact_path
    assert_response :success
    assert_select 'title', 'Kontakt | Blueliner Tippspiel'
  end
end
