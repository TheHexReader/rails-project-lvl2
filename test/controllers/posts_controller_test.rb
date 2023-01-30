# frozen_string_literal: true

require 'test_helper'

# Users controler tests
class PostsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in users(:one)
  end

  test 'test show' do
    post_one = posts(:one)
    get post_url(post_one)
    assert_response :success
  end

  test 'test new' do
    get new_post_path
    assert_response :success
  end

  test 'test create' do
    attrs = {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
      category_id: categories(:one).id
    }
    post posts_path, params: { post: attrs }

    post = Post.find_by(attrs)
    assert { post }
    assert_redirected_to post_path(post)

    assert_response :found
  end

  test 'test edit' do
    post_one = posts(:one)
    get edit_post_path(post_one)
    assert_response :success
  end

  test 'test update' do
    post_one = posts(:one)
    attrs = {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
      category: categories(:one).id
    }
    patch post_path(post_one), params: { post: attrs }

    post = Post.find_by(attrs)
    assert { post }
    assert_redirected_to post_path(post)

    assert_response :found
  end

  test 'test destroy' do
    post_one = posts(:one)

    delete post_path(post_one)

    assert_response :found
    assert { Post.find_by(id: post_one[:id]).nil? }
  end
end
