# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  setup do
    sign_in user
  end

  describe 'GET #create' do
    it 'redirects to root' do
      get :create, params: { requestee_id: friend.id }
      expect(response).to redirect_to(users_path)
    end

    it 'creates a new friendship' do
      expect do
        get :create, params: { requestee_id: friend.id }
      end.to change(Friendship, :count).by(1)
    end
  end

  describe 'GET #destroy' do
    it 'destroys the requested post' do
      create(:friendship, requester: user, requestee: friend)
      expect do
        delete :destroy, params: { requestee_id: friend.to_param }
      end.to change(Friendship, :count).by(-1)
    end
    it 'redirects to root' do
      create(:friendship, requester: user, requestee: friend)
      get :destroy, params: { requestee_id: friend.id }
      expect(response).to redirect_to(users_path)
    end
  end
end
