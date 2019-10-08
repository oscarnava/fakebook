# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :password, length: { in: 6..30 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes

  friendship_scope = -> { includes(:requester, :requestee).order('users.username') }
  has_many :following_friendships, friendship_scope, foreign_key: 'requester_id', class_name: :Friendship
  has_many :followers_friendships, friendship_scope, foreign_key: 'requestee_id', class_name: :Friendship

  default_scope { order(:username) }

  # Requests made by others to current_user
  def active_followers
    followers_friendships.where(status: :accepted).map(&:requester)
  end

  def pending_followers
    followers_friendships.where(status: :pending).map(&:requester)
  end

  # Requests made by current_user to others
  def pending_following
    following_friendships.where(status: :pending).map(&:requestee)
  end

  def active_following
    following_friendships.where(status: :accepted).map(&:requestee)
  end

  def rejected_followings
    following_friendships.where(status: :rejected).map(&:requestee)
  end

  def rejected_followers
    followers_friendships.where(status: :rejected).map(&:requester)
  end

  def remove_friendship(friend_id)
    following_friendships.find_by_requestee_id(friend_id)&.destroy ||
      followers_friendships.find_by_requester_id(friend_id)&.destroy
  end
end
