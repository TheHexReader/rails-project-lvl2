# frozen_string_literal: true

# Posts
module Posts
  # Comments controller
  class CommentsController < ApplicationController
    def new
      @comment = PostComment.new
    end

    def create
      puts params
      @comment = PostComment.new(comment_params.merge(process_params(params)))

      if @comment.save
        redirect_to post_path(comment_params[:post]), notice: 'success'
      else
        redirect_to post_path(comment_params[:post]), status: :unprocessable_entity
      end
    end

    def destroy
      @comment = PostComment.find(params[:id])
      if current_user['id'].to_s == @comment['user'].to_s
        @comment.destroy
        redirect_to post_path(params[:post_id]), notice: 'success'
      else
        redirect_to root_path, status: :unauthorized
      end
    end

    private

    def comment_params
      params.permit(:content, :user, :post, :id)
    end

    def process_params(params)
      {
        user: current_user['id'],
        parent: params['comment_id'].nil? ? nil : PostComment.find_by(id: params['comment_id'])
      }
    end
  end
end
