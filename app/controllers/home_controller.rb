# frozen_string_literal: true

# Home controller
class HomeController < ApplicationController
  def index
    @current_user_email = if current_user.nil?
                            'No user logged in'
                          else
                            current_user['email']
                          end
  end
end
