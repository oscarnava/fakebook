# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by('LOWER(username)= ?', params[:username].downcase)
    @comment = current_user.comments.new
  end
end
