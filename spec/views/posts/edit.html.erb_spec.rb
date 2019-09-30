# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/edit', type: :view do
  let(:user) { User.create(username: 'Dummy', email: 'dummy@dummy.com', password: 'abcdefg') }

  before(:each) do
    @post = assign(:post, Post.create!(content: 'MyString', user: user))
  end

  it 'renders the edit post form' do
    render

    assert_select 'form[action=?][method=?]', post_path(@post), 'post' do
      assert_select 'input[name=?]', 'post[content]'
      assert_select 'input[name=?]', 'post[user_id]'
    end
  end
end
