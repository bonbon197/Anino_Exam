class Api::V1::Leaderboard::EntryController < ApplicationController
    # Add score to the user's entry for the given leaderboard
    def add_score
      leaderboard = ::Leaderboard.find_by(_id: params[:id])
      user = ::User.find_by(_id: params[:user_id])
    
      if leaderboard.nil? || user.nil?
        render json: { errors: "Leaderboard or user not found" }, status: :not_found
        return
      end
    
      entry = Entry.find_by(user_id: user.id, leaderboard_id: leaderboard.id)
    
      if entry.nil?
        puts "Leaderboard: #{leaderboard.inspect}"
        puts "User: #{user.inspect}"
        entry = Entry.new(user_id: user.id, leaderboard_id: leaderboard.id, score: 0)
      end
    
      score_to_add = entry_params[:score_to_add].to_i
      puts "Score to add: #{score_to_add}"
      entry.increment!(:score, score_to_add)
      
      
      if entry.save
        response_data = {
          entry: {
            _id: entry.id,
            board_id: leaderboard._id,
            score: entry.score,
            scored_at: entry.updated_at,
            user_id: user._id
          }
        }
    
        render json: response_data, status: :ok
      else
        render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
    private

    def entry_params
      ActionController::Parameters.new(JSON.parse(request.body.read)).permit(:score_to_add)
    end
  end
  