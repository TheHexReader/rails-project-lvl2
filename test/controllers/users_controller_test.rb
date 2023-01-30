# frozen_string_literal: true

require 'test_helper'

# Users controler tests
class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
  end

  test 'test show' do
    get user_path(users(:one))
    assert_response :success
  end
end
