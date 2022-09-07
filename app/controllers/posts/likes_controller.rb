# frozen_string_literal: true

# Posts
module Posts
  # Likes controller
  class LikesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      return unless PostLike.where(like_params).empty?

      @like = PostLike.new(like_params.merge(current_user_hash))

      if @like.save
        redirect_to post_path(@like[:post_id]), notice: 'success'
      else
        redirect_to post_path(@like[:post_id]), status: :unprocessable_entity
      end
    end

    def destroy
      @like = PostLike.find(like_params[:id])

      if @like.delete
        redirect_to post_path(like_params[:post_id]), notice: 'success'
      else
        redirect_to post_path(like_params[:post_id]), status: :unprocessable_entity
      end
    end

    protected

    def current_user_hash
      { user: current_user[:id] }
    end

    def like_params
      params.permit(:post_id, :id).merge(current_user_hash)
    end
  end
end
