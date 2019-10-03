# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes

  has_many :following, foreign_key: 'requester_id', class_name: :Friendship
  # has_many :friends, through: :friendships, source: :requestee

  has_many :followers, foreign_key: 'requestee_id', class_name: :Friendship
  # has_many :followers, through: :requests, source: :requester

  default_scope { order(:username) }

  # Requests made by others to current_user
  def active_followers
    followers.filter(&:accepted?).map(&:requester).sort_by(&:username)
  end

  def pending_followers
    followers.filter(&:pending?).map(&:requester).sort_by(&:username)
  end

  # Requests made by current_user to others
  def pending_following
    following.filter(&:pending?).map(&:requestee).sort_by(&:username)
  end

  def active_following
    following.filter(&:accepted?).map(&:requestee).sort_by(&:username)
  end
end
