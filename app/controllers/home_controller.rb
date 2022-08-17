# frozen_string_literal: true

# Home controller
class HomeController < ApplicationController
  def index
    @posts = Post.all
  end
end
