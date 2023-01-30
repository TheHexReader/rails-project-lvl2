# frozen_string_literal: true

# Post controller
class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create new edit update destroy]

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).arrange
    @likes = @post.likes
    @like = @likes.find_by(user: current_user[:id]) if user_signed_in?
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post)
      flash[:notice] = t('post_created')
    else
      render :new
      flash[:notice] = t('cant_create_post')
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: t('success')
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      redirect_to user_path(current_user), notice: t('success')
    else
      redirect_to root_path, status: :unauthorized
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
