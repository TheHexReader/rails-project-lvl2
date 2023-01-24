# frozen_string_literal: true

require 'test_helper'

# Likes controler tests
class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test 'test create' do
    attrs = {
      user: users(:one).id
    }
    post post_likes_path(posts(:one)), params: { post_like: attrs }

    assert { PostLike.find_by(attrs, post_id: posts(:one).id) }
  end

  test 'test delete' do
    like_one = post_likes(:one)
    delete post_like_path(like_one, post_id: like_one[:post_id])

    assert { PostLike.find_by(id: like_one[:id]).nil? }
  end
end
