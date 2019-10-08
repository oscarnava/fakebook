# frozen_string_literal: true

class CommentsController < ApplicationController

  # POST /comments
  def create
    current_user.comments.create(comment_params)
    redirect_to root_path
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
