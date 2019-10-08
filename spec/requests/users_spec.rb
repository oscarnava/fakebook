# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /comments' do
    it 'redirects to the login page for an unauthenticated user' do
      get users_path
      expect(response).to redirect_to(new_user_session_url)
    end
    it 'return a successful response' do
      sign_in create(:user)
      get users_path
      expect(response).to have_http_status(200)
    end
  end
end
