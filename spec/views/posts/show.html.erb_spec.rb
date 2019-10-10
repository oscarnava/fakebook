# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/show', type: :view do
  let(:user) { create(:user) }

  before(:each) do
    assign(:post, create(:post, user: user))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Content/)
  end
end
