# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  let(:user) { create(:user) }

  before(:each) do
    assign(:users, create_list(:user, 4))
  end
  it 'renders attributes in <p>' do
    sign_in user
    render
    assert_select 'h1', text: 'Users'
    assert_select 'h2', text: 'All users'
    assert_select 'div.user-profile', count: 4
    assert_select 'div.user-profile img.gravatar', count: 4
  end
end
