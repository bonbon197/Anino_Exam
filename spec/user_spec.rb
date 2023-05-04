require 'rails_helper'

RSpec.describe Api::V1::UserController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { user: { name: 'John Doe' } } }

      it 'creates a new User' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'returns a created status (201)' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'returns the user with only :name and :_id attributes' do
        post :create, params: valid_params
        created_user = JSON.parse(response.body)
        expect(created_user.keys).to match_array(['name', '_id'])
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { user: { name: '' } } }

      it 'does not create a new User' do
        expect {
          post :create, params: invalid_params
        }.to_not change(User, :count)
      end

      it 'returns an unprocessable_entity status (422)' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an errors hash' do
        post :create, params: invalid_params
        errors = JSON.parse(response.body)['errors']
        expect(errors).to be_present
      end
    end
  end

  describe 'GET #show' do
    context 'with a valid :_id' do
      let(:user) { User.create(name: 'John Doe') }

      it 'returns the user with only :name and :_id attributes' do
        get :show, params: { id: user._id }
        found_user = JSON.parse(response.body)
        expect(found_user.keys).to match_array(['name', '_id'])
      end

      it 'returns an ok status (200)' do
        get :show, params: { id: user._id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with an invalid :_id' do
      it 'returns a not_found status (404)' do
        get :show, params: { id: 'nonexistent_id' }
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an errors hash' do
        get :show, params: { id: 'nonexistent_id' }
        errors = JSON.parse(response.body)['errors']
        expect(errors).to be_present
      end
    end
  end
end
