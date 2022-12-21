# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :post, foreign_key: :post
  belongs_to :user, foreign_key: :user
end
