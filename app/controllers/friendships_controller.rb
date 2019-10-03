class FriendshipsController < ApplicationController
  def create
    flash[:error] = "Couldn't befriend #{friendship_params[:requestee_id]}" unless current_user.following.new(friendship_params).save
    redirect_to users_path
  end

  def destroy
    current_user.following.destroy(params[:like_id])
    redirect_to users_path
  end

  def update
    request = current_user.followers.find_by(requester_id: params[:requester_id])
    flash[:error] = "Couldn't accept request from #{params[:requester_id]}" unless request.update(status: params[:status])
    redirect_to users_path
  end

  private

  def friendship_params
    params.permit(:requestee_id)
  end
end
