# frozen_string_literal: true

# Posts
module Posts
  # Likes controller
  class LikesController < ApplicationController
    def update
      @like_counter = PostLike.find(params[:id])

      if @like_counter.update(counter: @like_counter['counter'] + 1)
        redirect_to post_path(@like_counter['post_id']), notice: 'success'
      else
        redirect_to post_path(@like_counter['post_id']), status: :unprocessable_entity
      end
    end

    def destroy
      @like_counter = PostLike.find(params[:id])

      if @like_counter.update(counter: @like_counter['counter'] - 1)
        redirect_to post_path(@like_counter['post_id']), notice: 'success'
      else
        redirect_to post_path(@like_counter['post_id']), status: :unprocessable_entity
      end
    end
  end
end
