# frozen_string_literal: true

require 'test_helper'

# Likes controler tests
class LikesControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in users(:one)
  end

  test 'test create' do
    post post_likes_path(posts(:two))

    assert { PostLike.find_by( post_id: posts(:two).id, user: users(:one)) }
    assert_redirected_to post_path(posts(:two))
  end

  test 'test delete' do
    like_one = post_likes(:one)
    delete post_like_path(like_one, post_id: like_one[:post_id])

    assert { PostLike.find_by(id: like_one[:id]).nil? }
    assert_redirected_to post_path(posts(:one))
  end
end
