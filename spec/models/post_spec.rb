# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'saves and retrieves' do
    expect(Post.new).to be_invalid
    expect(create(:post)).to be_valid
  end
end
