# frozen_string_literal: true

# Create posts likes
class CreatePostLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_likes do |t|
      t.integer :post_id
      t.string :user

      t.timestamps
    end
  end
end
