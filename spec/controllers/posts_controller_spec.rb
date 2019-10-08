# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  setup do
    sign_in create(:user)
  end

  describe 'GET #index' do
    it 'blocks unauthenticated access' do
      sign_out :user
      get :index
      expect(response).to redirect_to(new_user_session_url)
    end
    it 'returns a success response' do
      create(:post)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      post = create(:post)
      get :show, params: { id: post.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      post = create(:post)
      get :edit, params: { id: post.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Post' do
        expect do
          post :create, params: { post: { content: Faker::Hipster.paragraph } }
        end.to change(Post, :count).by(1)
      end

      it 'redirects to the created post' do
        create(:post)
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { post: { content: '' } }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { content: Faker::Hipster.paragraph }
      end

      it 'updates the requested post' do
        post = create(:post)
        user = post.user
        put :update, params: { id: post.to_param, post: new_attributes }
        post.reload
        expect(post.content).to eq(new_attributes[:content])
        expect(post.user).to eq(user)
      end

      it 'redirects to the post' do
        post = create(:post)
        put :update, params: { id: post.to_param, post: new_attributes }
        expect(response).to redirect_to(post)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        create(:post)
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested post' do
      post = create(:post)
      expect do
        delete :destroy, params: { id: post.to_param }
      end.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
      post = create(:post)
      delete :destroy, params: { id: post.to_param }
      expect(response).to redirect_to(posts_url)
    end
  end
end
