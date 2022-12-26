# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, class_name: 'PostComment', foreign_key: :post
  has_many :likes, class_name: 'PostLike'

  validates :title, presence: true
  validates :body, presence: true
end
