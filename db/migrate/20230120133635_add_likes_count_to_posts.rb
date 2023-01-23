# frozen_string_literal: true

# Add likes counter to posts
class AddLikesCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :likes_count, :integer
  end
end
