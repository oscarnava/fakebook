# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'saves and retrieves' do
    expect(User.new).to be_invalid
    expect(create(:user)).to be_valid
  end
end
