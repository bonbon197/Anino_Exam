require 'rails_helper'

RSpec.describe Api::V1::LeaderboardController, type: :controller do
  describe 'GET #show' do
    let(:leaderboard) { Leaderboard.create(name: 'Sample Leaderboard') }
    let!(:user1) { User.create(name: 'User 1') }
    let!(:user2) { User.create(name: 'User 2') }
    let!(:entry1) { leaderboard.entries.create(user: user1, score: 100) }
    let!(:entry2) { leaderboard.entries.create(user: user2, score: 200) }

    context 'with a valid :_id' do
      it 'returns the leaderboard with :name and :_id attributes' do
        get :show, params: { id: leaderboard._id }
        found_leaderboard = JSON.parse(response.body)['board']
        expect(found_leaderboard.keys).to match_array(['_id', 'name', 'entries'])
      end

      it 'returns paginated leaderboard entries' do
        get :show, params: { id: leaderboard._id, per_page: 1, page: 1 }
        entries = JSON.parse(response.body)['board']['entries']
        expect(entries.length).to eq(1)
      end

      it 'returns entries with the correct attributes' do
        get :show, params: { id: leaderboard._id }
        entry = JSON.parse(response.body)['board']['entries'].first
        expect(entry.keys).to match_array(['score', 'user_id', 'scored_at', 'rank', 'name'])
      end

      it 'returns an ok status (200)' do
        get :show, params: { id: leaderboard._id }
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
