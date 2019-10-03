# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes, as: :likeable

  scope :posts_list, ->(user_ids) { where(user_id: user_ids).order(created_at: :desc) }
end
