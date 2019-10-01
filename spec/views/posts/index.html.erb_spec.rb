# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  before(:each) do
    @user = create(:user)
    assign(:posts, [
             Post.create!(
               content: 'Content',
               user: @user
             ),
             Post.create!(
               content: 'Content',
               user: @user
             )
           ])
  end

  it 'renders a list of posts' do
    render
    assert_select 'tr>td', text: 'Content', count: 2
    assert_select 'tr>td:nth-child(2)', text: @user.id.to_s, count: 2
  end
end
