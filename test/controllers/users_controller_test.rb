# frozen_string_literal: true

require 'test_helper'

# Users controler tests
class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get new_user_session_path
    sign_in users(:one)
    post user_session_path
  end

  test 'test show' do
    get user_path(users(:one))
    assert_select 'h1', text: users(:one)['email']
  end
end
