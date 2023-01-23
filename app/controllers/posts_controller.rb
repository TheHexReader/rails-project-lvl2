# frozen_string_literal: true

# Post controller
class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create new edit update destroy]
  skip_before_action :verify_authenticity_token

  def show
    @post = Post.includes(:category).find(params[:id])
    @comments = @post.comments.includes(:user).arrange
    @likes = @post.likes
    @like = @likes.find_by(user: current_user[:id])
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post)
      flash[:notice] = t('post_created')
    else
      render :new
      flash[:notice] = t('cant_create_post') if @post.category_id.nil?
    end
  end

  def new
    @post = Post.new
  end

  def edit
    if current_user.posts.find(params[:id]).creator_id == current_user.id
      @post = Post.find params[:id]
    else
      redirect_to root_path
    end
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
