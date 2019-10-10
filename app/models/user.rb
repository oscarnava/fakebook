# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :password, length: { in: 6..30 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
