# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'comments/new', type: :view do
  let(:user) { create(:user) }

  it 'renders new comment form' do
    sign_in user
    comment = Comment.new
    post = create(:post, user: user)
    create_list(:comment, 2, user: user, post: post, content: 'Content')
    render 'comments/form', { post: post, comment: comment }

    assert_select 'form[action=?][method=?]', comments_path, 'post' do
      assert_select 'textarea[name=?]', 'comment[content]'
      assert_select 'input[type=?]', 'submit'
    end
  end
end
