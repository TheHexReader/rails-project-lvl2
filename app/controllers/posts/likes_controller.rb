# frozen_string_literal: true

# Posts
module Posts
  # Likes controller
  class LikesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      return unless PostLike.where({ id: like_params[:id] }).empty?

      @like = PostLike.new(like_params.merge(user_id: current_user.id))

      if @like.save
        redirect_to post_path(like_params[:post_id]), notice: t('success')
      else
        redirect_to post_path(like_params[:post_id]), status: :unprocessable_entity
      end
    end

    def destroy
      @like = PostLike.find(like_params[:id])

      if @like.delete
        redirect_to post_path(like_params[:post_id]), notice: t('success')
      else
        redirect_to post_path(like_params[:post_id]), status: :unprocessable_entity
      end
    end

    protected

    def like_params
      params.permit(:post_id, :id)
    end
  end
end
