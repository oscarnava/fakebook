# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    warn "\n\n*** #{params} ***\n\n"
    flash[:error] = "Couldn't like the #{like_params[:likeable_type]}" unless current_user.likes.new(like_params).save
    redirect_to :root
  end

  def destroy
    current_user.likes.destroy(params[:like_id])
    redirect_to :root
  end

  private

  def like_params
    params.permit(:likeable_type, :likeable_id)
  end
end
