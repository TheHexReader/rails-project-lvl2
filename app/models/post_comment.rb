# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry
  belongs_to :post, foreign_key: :post
  belongs_to :user, foreign_key: :user

  validates :content, presence: true
end
