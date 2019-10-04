# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

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
