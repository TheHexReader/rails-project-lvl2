# frozen_string_literal: true

# Posts
module Posts
  # Likes controller
  class LikesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      p '--- Like params ---'
      p like_params
      
      return unless PostLike.where({ id: like_params[:id] }).empty?

      @like = PostLike.new(like_params)

      if @like.save
        redirect_to post_path(like_params[:post]), notice: t('success')
      else
        redirect_to post_path(like_params[:post]), status: :unprocessable_entity
      end
    end

    def destroy
      @like = PostLike.find(like_params[:id])

      if @like.delete
        redirect_to post_path(like_params[:post]), notice: t('success')
      else
        redirect_to post_path(like_params[:post]), status: :unprocessable_entity
      end
    end

    protected

    def like_params
      permited = params.permit(:post_id, :id)

      {
        user: current_user,
        post: Post.find_by(id: permited[:post_id]),
        id: permited[:id]
      }
    end
  end
end
