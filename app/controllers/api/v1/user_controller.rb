class Api::V1::UserController < ApplicationController
    #create user with just name
    def create
        user = User.new(user_params)
        #user._id = SecureRandom.uuid
        if user.save
            render json: user.as_json(only: [:name, :_id]), status: :created
        else
            #handle errors
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    #get user based on :_id
    def show
        user = User.find_by(_id: params[:id])
        if user
            render json: user.as_json(only: [:name, :_id]), status: :ok
        else
            render json: { errors: "User not found" }, status: :not_found
        end
    end

    private
    def user_params
        params.require(:user).permit(:name)
    end
end