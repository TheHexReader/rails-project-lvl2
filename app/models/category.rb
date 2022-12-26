# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :posts, foreign_key: :category
end
