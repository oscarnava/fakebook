# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    it 'redirects an unauthorized user to the login page' do
      get posts_path
      expect(response).to redirect_to(new_user_session_url)
    end
    it 'returns a successful response for an authorized user' do
      sign_in create(:user)
      get posts_path
      expect(response).to have_http_status(200)
    end
  end
end
