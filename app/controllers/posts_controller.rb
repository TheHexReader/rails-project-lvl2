# frozen_string_literal: true

# User controller
class PostsController < ApplicationController
  def show
    @post = Post.find_by(id: params[:id])
    return if @post.nil?

    @comments = PostComment.where(post_id: @post['id'].to_i, ancestry: nil)
    @likes = PostLike.where(post: @post)
  end

  def create
    @post = Post.new(post_params.merge(creator: current_user['id']))

    if @post.save
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
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]

    if @post.update(post_params.merge(creator: current_user['id']))
      redirect_to @post, notice: 'success'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find params[:id]
    if current_user['id'].to_s == @post['creator'].to_s
      @post.destroy
      redirect_to user_path(current_user), notice: 'success'
    else
      redirect_to root_path, status: :unauthorized
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :creator, :category_id)
  end
end
