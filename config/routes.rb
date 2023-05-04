Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :user
      
      #this is giving me headaches
      put '/leaderboard/:id/user/:user_id/add_score', to: 'leaderboard/entry#add_score'
      get '/leaderboard/:id', to: 'leaderboard#show'
      # resources :leaderboard, only: [:show], param: :_id, controller: 'api/v1/leaderboard'

      # resources :leaderboard, only: [], param: :_id

      

      namespace :admin do
        resources :leaderboard
      end
    end
  end

end
