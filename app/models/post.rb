class Post < ApplicationRecord
  belongs_to :user

  scope :posts_list, -> { order created_at: :desc }

end
