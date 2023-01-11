# frozen_string_literal: true

# Posts
module Posts
  # Likes controller
  class LikesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      p '--- Like params ---'
      p like_params
      p '--- Processed params ---'
      p processed_params
      
      return unless PostLike.where({ id: like_params[:id] }).empty?

      @like = PostLike.new(processed_params)

      if @like.save
        redirect_to post_path(processed_params[:post]), notice: t('success')
      else
        redirect_to post_path(processed_params[:post]), status: :unprocessable_entity
      end
    end

    def destroy
      @like = PostLike.find(like_params[:id])

      if @like.delete
        redirect_to post_path(processed_params[:post]), notice: t('success')
      else
        redirect_to post_path(processed_params[:post]), status: :unprocessable_entity
      end
    end

    protected

    def processed_params
      p '--- Test find_by start ---'
      out = {
        user: current_user,
        post: Post.find_by(id: like_params[:post_id])
      }
      p '--- Test find_by end ---'
      out
    end

    def like_params
      params.permit(:post_id, :id)
    end
  end
end
