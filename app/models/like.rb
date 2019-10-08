# frozen_string_literal: true

class Like < ApplicationRecord
  validates :user, presence: true
  validates :likeable, presence: true

  belongs_to :user
  belongs_to :likeable, polymorphic: true
end
