# frozen_string_literal: true

# Posts
module Posts
  # Comments controller
  class CommentsController < ApplicationController
    before_action :authenticate_user!

    def new
      @comment = PostComment.new
    end

    def create
      @comment = PostComment.new(comment_params)
      if @comment.save
        redirect_to post_path(@comment.post), notice: t('success')
      else
        redirect_to post_path(@comment.post), status: :unprocessable_entity
      end
    end

    def destroy
      @comment = PostComment.find(params[:id])
      if current_user.email == @comment.user.email
        @comment.destroy
        redirect_to post_path(@comment.post), notice: t('success')
      else
        redirect_to root_path, status: :unauthorized
      end
    end

    private

    def comment_params
      params.require(:post_comment).permit(:content).merge(params.permit(:post_id)).merge(user_id: current_user.id)
    end
  end
end
