#leaderboard controller without the admin namespace
require_relative '../../../models/leaderboard.rb'
class Api::V1::LeaderboardController < ApplicationController
    #get leaderboard based on :_id
    def show
        leaderboard = Leaderboard.find_by(_id: params[:id])
        if leaderboard
            page = params.fetch(:page, 1).to_i
            per_page = params.fetch(:per_page, 10).to_i
      
            sorted_entries = leaderboard.entries.includes(:user).order(score: :desc, created_at: :asc).paginate(page: page, per_page: per_page)
      
            entries = sorted_entries.map do |entry|{
                  score: entry.score,
                  user_id: entry.user._id,
                  scored_at: entry.created_at,
                  rank: entry.rank,
                  name: entry.user.name
                }
            end

            response_data = {
                board: {
                    _id: leaderboard._id,
                    name: leaderboard.name,
                    entries: entries
                }
            }

            render json: response_data, status: :ok
        else
            render json: { errors: "Leaderboard not found" }, status: :not_found
        end
    end

    private
    def leaderboard_params
        params.require(:leaderboard).permit(:name)
    end
end