class Api::V1::UsersController < ApplicationController
    #create user with just name
    def create
        user = User.new(user_params)
        if user.save
            render json: user.as_json(only: [:name, :_id]), status: :created
        else
            #handle errors
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :_id)
    end
end