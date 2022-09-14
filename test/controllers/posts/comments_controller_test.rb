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

  test 'test new' do
    get new_post_comment_path(@post_one['id'])
    assert_select 'h1', text: 'Создать коментарий'
  end

  test 'test create' do
    attrs = {
      content: 'Some comment text',
      user: 1,
      post_id: 1
    }
    post post_comments_path(@post_one), params: { comment: attrs }

    assert_redirected_to post_path(Post.find_by(id: attrs[:post_id]))
    assert_select '*', text: attrs['comments']
  end

  test 'test destroy' do
    comment_one = post_comments(:one)

    delete post_comment_path(comment_one, post_id: comment_one[:post_id])

    assert PostComment.find_by(id: comment_one[:id]).nil?
  end
end
