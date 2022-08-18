# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get new_user_session_path
    sign_in users(:one)
    post user_session_path
  end

  test 'test new' do
    get new_comment_path
    assert_select 'h1', text: 'Создать коментарий'
  end

  test 'test create' do
    attrs = {
      comments: 'Some comment text',
      creator: 1,
      posts_id: '1'
    }
    post comments_path, params: attrs

    assert_redirected_to post_path(Post.find_by(id: PostComment.find_by(attrs)['posts_id'])['id'])
    assert_select '*', text: attrs['comments']
  end

  test 'test destroy' do
    comment_one = post_comments(:one)

    delete comment_path(comment_one, posts_id: comment_one['posts_id'])

    assert PostComment.find_by(id: comment_one[:id]).nil?
  end
end
