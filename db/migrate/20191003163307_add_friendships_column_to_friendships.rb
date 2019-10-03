# frozen_string_literal: true

class AddFriendshipsColumnToFriendships < ActiveRecord::Migration[6.0]
  def change
    add_column :friendships, :relation, :string
    add_index :friendships, :relation, unique: true
  end
end
