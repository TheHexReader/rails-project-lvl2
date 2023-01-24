# frozen_string_literal: true

require 'test_helper'

# Users controler tests
class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'test index' do
    get root_path
    assert_response :success
  end
end
