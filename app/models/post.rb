# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  scope :posts_list, ->(user) { where('user_id = ?', user).order(created_at: :desc) }
end
