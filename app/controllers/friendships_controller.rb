class FriendshipsController < ApplicationController
  def create
    flash[:error] = "Couldn't befriend #{friendship_params[:requestee_id]}" unless current_user.friends.new(like_params).save
    redirect_to :root
  end

  def destroy
    current_user.friends.destroy(params[:like_id])
    redirect_to :root
  end

  private

  def friendship_params
    params.permit(:requestee_id)
  end
end
