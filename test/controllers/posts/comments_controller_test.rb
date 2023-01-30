# frozen_string_literal: true

require 'test_helper'

# Comments controller test
class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @post_one = posts(:one)
  end

  test 'test create' do
    attrs = {
      content: Faker::Lorem.sentence,
      parent_id: post_comments(:one).id
    }
    post post_comments_path(@post_one), params: { post_comment: attrs }

    comment = PostComment.find_by(
      content: attrs[:content],
      user_id: users(:one).id,
      ancestry: attrs[:parent_id],
      post_id: @post_one.id
    )
    assert { comment }

    assert_response :found
    assert_redirected_to post_path(@post_one)
  end
end
