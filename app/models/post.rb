# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, class_name: 'PostComment'
  has_many :likes, class_name: 'PostLike'

  has_one :creator_id, class_name: 'User'
  has_one :category_id, class_name: 'Category'

  validates :title, presence: true
  validates :body, presence: true
end
