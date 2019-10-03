# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    following = current_user.following.new(friendship_params)
    flash[:error] = "Couldn't befriend #{friendship_params[:requestee_id]}" unless following.save
    redirect_to users_path
  end

  def destroy
    current_user.following.destroy(params[:like_id])
    redirect_to users_path
  end

  def update
    request = current_user.followers.find_by(requester_id: params[:requester_id])
    flash[:error] = "Couldn't accept request." unless request.update(status: params[:status])
    redirect_to users_path
  end

  private

  def friendship_params
    params.permit(:requestee_id)
  end
end
