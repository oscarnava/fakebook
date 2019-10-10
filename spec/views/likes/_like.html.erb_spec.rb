# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'likes/partials/_like', type: :view do
  let(:user) { create(:user) }

  it 'renders a like for a post' do
    sign_in user
    post = create(:post, user: user)
    render 'likes/partials/like', likeable: post
    assert_select 'a.option-button>img'
    assert_select 'img:match("src", ?)', /thumbs-up/
    assert_select 'a.option-button', text: /\d/
  end
end
