# frozen_string_literal: true

require 'test_helper'

# Users controler tests
class PostLikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get new_user_session_path
    sign_in users(:one)
    post user_session_path
  end

  test 'test update' do
    post_likes_one = post_likes(:one)
    patch like_path(post_likes_one)

    assert_redirected_to post_path(post_likes_one['post_id'])
    assert PostLike.find_by(id: post_likes_one['id'])['counter'] == post_likes_one['counter'] + 1
  end
end
