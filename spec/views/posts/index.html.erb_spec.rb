# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  let(:user) { User.create(username: 'Dummy', email: 'dummy@dummy.com', password: 'abcdefg') }

  before(:each) do
    assign(:posts, [
             Post.create!(
               content: 'Content',
               user: user
             ),
             Post.create!(
               content: 'Content',
               user: user
             )
           ])
  end

  it 'renders a list of posts' do
    render
    assert_select 'tr>td', text: 'Content', count: 2
    assert_select 'tr>td:nth-child(2)', text: user.id.to_s, count: 2
  end
end
