class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.text :comments
      t.string :creator
      t.belongs_to :posts

      t.timestamps
    end
  end
end
