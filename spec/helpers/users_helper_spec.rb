# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { create(:user) }

  it 'returns an image tag with the gravatar' do
    gravatar = gravatar_for(user)
    expect(gravatar).to match(/secure.gravatar.com/)
  end
end
