# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry
  belongs_to :post
end
