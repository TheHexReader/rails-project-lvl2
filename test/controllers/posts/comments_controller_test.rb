# frozen_string_literal: true

require 'test_helper'

# Comments controller test
class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get new_user_session_path
    sign_in users(:one)
    post user_session_path
    @post_one = posts(:one)
  end

  test 'test create' do
    attrs = {
      content: Faker::Lorem.sentence,
      user_id: 1,
      post_id: 1
    }
    post post_comments_path(@post_one), params: { post_comment: attrs }

    assert_redirected_to post_path(Post.find_by(id: attrs[:post_id]))
    assert_select '*', text: attrs[:comments]
  end
end
