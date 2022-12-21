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

  test 'test create' do
    attrs = {
      user: '1'
    }
    post post_likes_path(posts(:one)), params: { post_like: attrs }

    assert { !PostLike.find_by(attrs).nil? }
  end

  test 'test delete' do
    like_one = post_likes(:one)
    delete post_like_path(like_one, post_id: like_one[:post])

    assert { PostLike.find_by(id: like_one[:id]).nil? }
  end
end
