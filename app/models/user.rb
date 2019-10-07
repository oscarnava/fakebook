# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes

  has_many :following_friendships, foreign_key: 'requester_id', class_name: :Friendship
  has_many :followers_friendships, foreign_key: 'requestee_id', class_name: :Friendship

  default_scope { order(:username) }

  # Requests made by others to current_user
  def active_followers
    followers_friendships.filter(&:accepted?).map(&:requester).sort_by(&:username)
  end

  def pending_followers
    followers_friendships.filter(&:pending?).map(&:requester).sort_by(&:username)
  end

  # Requests made by current_user to others
  def pending_following
    following_friendships.filter(&:pending?).map(&:requestee).sort_by(&:username)
  end

  def active_following
    following_friendships.filter(&:accepted?).map(&:requestee).sort_by(&:username)
  end

  def rejected_followings
    following.filter(&:rejected?).map(&:requestee).sort_by(&:username)
  end

  def rejected_followers
    followers.filter(&:rejected?).map(&:requester).sort_by(&:username)
  end

  def remove_friendship(friend_id)
    following.find_by_requestee_id(friend_id)&.destroy || followers.find_by_requester_id(friend_id)&.destroy
  end
end
