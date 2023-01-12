# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, class_name: 'PostComment'
  has_many :likes, class_name: 'PostLike'

  has_one :user, foreign_key: 'creator_id'
  has_one :category, foreign_key: 'category_id'

  validates :title, presence: true
  validates :body, presence: true
end
