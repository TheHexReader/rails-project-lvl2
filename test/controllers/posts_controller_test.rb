# frozen_string_literal: true

require 'test_helper'

# Users controler tests
class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get new_user_session_path
    sign_in users(:one)
    post user_session_path
  end

  test 'test show user' do
    get root_path
    assert_select '.nav-link', text: users(:one)['email']
  end

  test 'test show' do
    post_one = posts(:one)
    get post_url(post_one)
    assert_select 'a', text: post_one['title']
  end

  test 'test new' do
    get new_post_path
    assert_select 'h4', text: 'Новый пост'
  end

  test 'test create' do
    attrs = {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
      category_id: 1
    }
    post posts_path, params: { post: attrs }

    assert_redirected_to post_path(Post.find_by(attrs))
    assert_select '*', text: attrs['title']
  end

  test 'test edit' do
    post_one = posts(:one)
    get edit_post_path(post_one)
    assert_select 'h4', text: 'Редактировать пост'
  end

  test 'test update' do
    post_one = posts(:one)
    attrs = {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
      category: 1
    }
    patch post_path(post_one), params: { post: attrs }

    assert_redirected_to post_path(post_one)
    assert_select 'a', text: attrs['title']
  end

  test 'test destroy' do
    post_one = posts(:one)

    delete post_path(post_one)

    assert { Post.find_by(id: post_one[:id]).nil? }
  end
end
