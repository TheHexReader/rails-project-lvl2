# frozen_string_literal: true

# User controller
class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(creator_id: @user)
  end
end
