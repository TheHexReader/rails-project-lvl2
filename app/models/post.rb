# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, class_name: 'PostComment'
  has_many :likes, class_name: 'PostLike'

  has_one :category
  has_one :creator, class_name: 'User'

  validates :title, presence: true
  validates :body, presence: true
end
