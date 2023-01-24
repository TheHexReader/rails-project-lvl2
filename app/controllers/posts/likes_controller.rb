# frozen_string_literal: true

# Posts
module Posts
  # Likes controller
  class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
      return unless find_likes

      @like = Post.find(params[:post_id]).likes.build(user_id: current_user.id)

      if @like.save
        redirect_to post_path(params[:post_id]), notice: t('success')
      else
        redirect_to post_path(params[:post_id]), status: :unprocessable_entity
      end
    end

    def destroy
      @like = PostLike.find(params[:id])

      if @like.delete
        redirect_to post_path(params[:post_id]), notice: t('success')
      else
        redirect_to post_path(params[:post_id]), status: :unprocessable_entity
      end
    end

    private

    def find_likes
      PostLike.where({ id: params[:id] }).empty?
    end
  end
end
