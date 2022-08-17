# frozen_string_literal: true

# migration posts
class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :creator
      t.belongs_to :categories

      t.timestamps
    end
  end
end
