# frozen_string_literal: true

# User controller
class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @post = Post.find_by(id: params[:id])
    return if @post.nil?

    @comments = PostComment.where(post_id: @post.id, ancestry: nil)
    @likes = PostLike.where(post: @post)
  end

  def create
    @post = Post.new(post_params.merge(creator: current_user.id))

    if @post.save && !post_params[:category].nil? && check_if_category_is_chosen
      flash[:notice] = 'Пост создан'
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all

    if Post.find_by(id: params[:id]).creator.to_i == current_user.id
      @post = Post.find params[:id]
    else
      redirect_to root_path
    end
  end

  def update
    @post = Post.find params[:id]

    unless check_if_category_is_chosen
      redirect_to edit_post_path(@post)
      return
    end

    if @post.update(post_params.merge(creator: current_user['id']))
      redirect_to @post, notice: t('success')
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    if current_user.id.to_s == @post[:creator].to_s
      @post.destroy
      redirect_to user_path(current_user), notice: t('success')
    else
      redirect_to root_path, status: :unauthorized
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :creator, :category)
  end

  def check_if_category_is_chosen
    return true unless post_params[:category] == ''

    flash[:notice] = 'Не выбранна категория'
    false
  end
end
