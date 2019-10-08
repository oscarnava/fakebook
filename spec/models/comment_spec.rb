# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'saves' do
    expect(Comment.new).to be_invalid
    expect(create(:comment)).to be_valid
  end
end
