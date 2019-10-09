# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  setup do
    sign_in create(:user)
  end

  describe 'POST #create' do
    it 'should log in / out a user' do
      sign_out :user
      expect(subject.current_user).to eq(nil)
    end

    context 'with valid params' do
      it 'creates a new Comment' do
        expect do
          post :create, params: { comment: { content: Faker::Hipster.paragraph, post_id: (create :post).id } }
        end.to change(Comment, :count).by(1)
      end
      it 'redirects to the post index page - root' do
        post :create, params: { comment: { content: Faker::Hipster.paragraph, post_id: (create :post).id } }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        post :create, params: { comment: { content: '', post_id: (create :post).id } }
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
