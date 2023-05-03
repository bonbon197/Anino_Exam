class Api::V1::Leaderboard::EntryController < ApplicationController
    # Add score to the user's entry for the given leaderboard
    def add_score
      puts "Parameters: #{params.inspect}"
      
      leaderboard = ::Leaderboard.find_by(_id: params[:id])
      user = ::User.find_by(_id: params[:user_id])
  
      if leaderboard.nil? || user.nil?
        render json: { errors: "Leaderboard or user not found" }, status: :not_found
        return
      end
  
      entry = Entry.find_or_initialize_by(user: user, leaderboard: leaderboard)
      
      entry.score ||= 0
      score_to_add = entry_params[:score_to_add].to_i
      entry.score += score_to_add
      entry.save!
  
      response_data = {
        entry: {
          _id: entry.id,
          board_id: leaderboard._id,
          score: entry.score,
          scored_at: entry.created_at,
          user_id: user._id
        }
      }
  
      render json: response_data, status: :ok
    end

    private

    def entry_params
      params.permit(:score_to_add)
    end
  end
  