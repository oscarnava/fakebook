# frozen_string_literal: true

class AddKeyForLikes < ActiveRecord::Migration[6.0]
  def change; end
  add_index :likes, %i[user_id likeable_type likeable_id], unique: true
end
