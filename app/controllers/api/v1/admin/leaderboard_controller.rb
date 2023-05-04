#leaderboard controller
class Api::V1::Admin::LeaderboardController < ApplicationController
    #create a leaderboard
    #api/v1/admin/leaderboard?leaderboard[name]="your value"
    def create
        leaderboard = ::Leaderboard.new(leaderboard_params)
        if leaderboard.save
            render json: leaderboard.as_json(only: [:name, :_id]), status: :created
        else
            #handle errors
            render json: { errors: leaderboard.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # #get leaderboard based on :_id
    # def show
    #     leaderboard = Leaderboard.find_by(_id: params[:id])
    #     if leaderboard
    #         render json: leaderboard.as_json(only: [:name, :_id]), status: :ok
    #     else
    #         render json: { errors: "Leaderboard not found" }, status: :not_found
    #     end
    # end

    private
    def leaderboard_params
        params.require(:leaderboard).permit(:name)
    end
end