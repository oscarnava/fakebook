# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, presence: true
  validates :user, presence: true
  validates :post, presence: true

  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable
end
