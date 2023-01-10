# frozen_string_literal: true

# Posts
module Posts
  # Likes controller
  class LikesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      return unless PostLike.where(processed_params).empty?

      @like = PostLike.new(processed_params)

      if @like.save
        redirect_to post_path(like_params[:post_id]), notice: t('success')
      else
        redirect_to post_path(like_params[:post_id]), status: :unprocessable_entity
      end
    end

    def destroy
      @like = PostLike.find(like_params[:id])

      if @like.delete
        redirect_to post_path(@like.post), notice: t('success')
      else
        redirect_to post_path(@like.post), status: :unprocessable_entity
      end
    end

    protected

    def processed_params
      {
        user: current_user,
        post: Post.find_by(id: like_params[:post_id])
      }
    end

    def like_params
      params.permit(:post_id, :id)
    end
  end
end
