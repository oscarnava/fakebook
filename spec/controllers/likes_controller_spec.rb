# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment, post: post, user: user) }

  setup do
    sign_in user
  end

  describe 'GET #create' do
    it 'redirects to root' do
      get :create, params: { likeable_type: :Post, likeable_id: post.to_param }
      expect(response).to redirect_to(root_path)
    end

    it 'creates a new like to a post' do
      expect do
        get :create, params: { likeable_type: :Post, likeable_id: post.to_param }
      end.to change(Like, :count).by(1)
    end
    it 'creates a new like to a comment' do
      expect do
        get :create, params: { likeable_type: :Comment, likeable_id: comment.to_param }
      end.to change(Like, :count).by(1)
    end
  end

  describe 'GET #destroy' do
    it 'destroys the requested post' do
      like = create(:like, likeable: post, user: user)
      expect do
        get :destroy, params: { like_id: like.to_param }
      end.to change(Like, :count).by(-1)
    end
    it 'redirects to root' do
      like = create(:like, likeable: post, user: user)
      get :destroy, params: { like_id: like.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
