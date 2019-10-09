# frozen_string_literal: true

class AddDefaultStateToFriendship < ActiveRecord::Migration[6.0]
  def change
    change_column_default :friendships, :status, 0
    change_column_null :friendships, :status, false
  end
end
