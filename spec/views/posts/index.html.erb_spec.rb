# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  let(:user) { create(:user) }

  before(:each) do
    assign(:post, Post.new)
    assign(:comment, Comment.new)
    assign(:posts, create_list(:post, 2, user: user, content: 'Content'))
  end

  setup do
    sign_in user
  end
  it 'renders a list of posts' do
    render
    assert_select '.post-main>.content', text: 'Content', count: 2
    assert_select '.post-header>.user-inset>.name', text: user.username, count: 2
  end
  it 'renders new post form' do
    render
    assert_select 'form[action=?][method=?]', posts_path, 'post' do
      assert_select 'textarea[name=?]', 'post[content]'

      assert_select 'input[type=?]', 'submit'
    end
  end
end
