# frozen_string_literal: true

# User controller
class LikesController < ApplicationController
  def update
    @like_counter = PostLike.find(params[:id])

    if @like_counter.update(counter: @like_counter['counter'] + 1)
      redirect_to post_path(@like_counter['posts_id']), notice: 'success'
    else
      redirect_to post_path(@like_counter['posts_id']), status: :unprocessable_entity
    end
  end
end
