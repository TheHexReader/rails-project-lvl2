# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :post, optional: true
end