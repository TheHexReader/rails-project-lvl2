# frozen_string_literal: true

require 'test_helper'

# Likes controler tests
class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get new_user_session_path
    sign_in users(:one)
    post user_session_path
  end

  test 'test update' do
    likes_one = post_likes(:one)
    patch post_like_path(likes_one, post_id: likes_one['post_id'])

    assert_redirected_to post_path(likes_one['post_id'])
    assert PostLike.find_by(id: likes_one['id'])['counter'] == likes_one['counter'] + 1
  end
end
