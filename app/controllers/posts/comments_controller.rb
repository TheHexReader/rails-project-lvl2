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
      @comment = PostComment.new(comment_params.merge(process_params(params)))

      if @comment.save
        redirect_to post_path(comment_params[:post_id]), notice: t('success')
      else
        redirect_to post_path(comment_params[:post_id]), status: :unprocessable_entity
      end
    end

    def destroy
      @comment = PostComment.find(params[:id])
      if current_user.email == @comment.user
        @comment.destroy
        redirect_to post_path(params[:post_id]), notice: t('success')
      else
        redirect_to root_path, status: :unauthorized
      end
    end

    private

    def comment_params
      params.require(:post_comment).permit(:content).merge(params.permit(:user, :post_id))
    end

    def process_params(params)
      {
        user: current_user.email,
        parent: if params['post_comment']['comment_id'].nil?
                  nil
                else
                  PostComment.find_by(id: params['post_comment']['comment_id'])
                end
      }
    end
  end
end
