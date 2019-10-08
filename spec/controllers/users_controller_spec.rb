# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  setup do
    sign_in user
  end

  describe 'GET #index' do
    it 'blocks unauthenticated access' do
      sign_out :user
      get :index
      expect(response).to redirect_to(new_user_session_url)
    end
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { username: user.username }
      expect(response).to be_successful
    end
  end
end
