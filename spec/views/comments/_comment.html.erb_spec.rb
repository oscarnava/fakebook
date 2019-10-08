# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'comments/partials/_comment', type: :view do
  let(:user) { create(:user) }

  it 'renders a list of comments' do
    sign_in user
    comment = Comment.new
    post = create(:post, user: user)
    create_list(:comment, 2, user: user, post: post, content: 'Content')
    render 'comments/partials/comment', post: post, comment: comment
    assert_select '.comment>.commment-content', text: 'Content'.to_s, count: 2
  end
end
