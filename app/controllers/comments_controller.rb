# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  # POST /comments
  def create
    u = User.create(username: 'abc', email: 'x@x.com', password: 'abcdefg')
    p = Post.create(content: 'abc', user_id: u.id)
    Comment.create(content: 'abc', user_id: u.id, post_id: p.id)
    # @comment = current_user.comments.new(comment_params)
    # @comment.save if @comment.valid?
    # redirect_to root_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
