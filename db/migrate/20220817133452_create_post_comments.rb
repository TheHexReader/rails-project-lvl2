# frozen_string_literal: true

# Create post comments
class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.text :content
      t.string :user
      t.integer :post_id
      t.string :post

      t.timestamps
    end
  end
end
