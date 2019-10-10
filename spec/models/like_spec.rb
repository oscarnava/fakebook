# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'saves and retrieves' do
    expect(Like.new).to be_invalid
    expect(create(:like)).to be_valid
  end
end
