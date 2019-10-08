# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'saves and retrieves' do
    expect(Friendship.new).to be_invalid
    expect(create(:friendship)).to be_valid
    expect(create(:friendship, status: :accepted)).to be_valid
    expect(create(:friendship, status: :rejected)).to be_valid
  end

  it 'creates a friendship' do
    alice = create :user
    bob = create :user
    expect(create(:friendship, requester: alice, requestee: bob)).to be_valid
    expect { create(:friendship, requester: bob, requestee: alice) }.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
