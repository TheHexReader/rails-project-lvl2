# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  belongs_to :creator, class_name: 'User'
  belongs_to :category, class_name: 'Category'

  validates :title, presence: true
  validates :body, presence: true
  validates :category_id, presence: true
end
