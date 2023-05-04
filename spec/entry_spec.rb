require 'rails_helper'

RSpec.describe Api::V1::Leaderboard::EntryController, type: :controller do
  describe 'PUT #add_score' do
    let(:leaderboard) { Leaderboard.create(name: 'Sample Leaderboard') }
    let(:user) { User.create(name: 'John Doe') }
    let!(:entry) { leaderboard.entries.create(user: user, score: 100) }

    context 'with valid leaderboard and user ids' do
      it 'increments the user entry score' do
        expect {
          put :add_score, params: { id: leaderboard._id, user_id: user._id }, body: { score_to_add: 50 }.to_json, as: :json
          entry.reload
        }.to change(entry, :score).by(50)
      end

      it 'returns an ok status (200)' do
        put :add_score, params: { id: leaderboard._id, user_id: user._id }, body: { score_to_add: 50 }.to_json, as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated entry with correct attributes' do
        put :add_score, params: { id: leaderboard._id, user_id: user._id }, body: { score_to_add: 50 }.to_json, as: :json
        updated_entry = JSON.parse(response.body)['entry']
        expect(updated_entry.keys).to match_array(['_id', 'board_id', 'score', 'scored_at', 'user_id'])
      end
    end

    context 'with invalid leaderboard or user ids' do
      it 'returns a not_found status (404)' do
        put :add_score, params: { id: 'nonexistent_id', user_id: user._id, score_to_add: 50 }
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an errors hash' do
        put :add_score, params: { id: 'nonexistent_id', user_id: user._id, score_to_add: 50 }
        errors = JSON.parse(response.body)['errors']
        expect(errors).to be_present
      end
    end
  end
end
