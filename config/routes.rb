Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :user
      
      #this is giving me headaches
      put '/leaderboard/:id/user/:user_id/add_score', to: 'leaderboard/entry#add_score'
      resources :leaderboard, only: [], param: :_id

      

      namespace :admin do
        resources :leaderboard
      end
    end
  end

end
