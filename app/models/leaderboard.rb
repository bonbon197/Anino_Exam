class Leaderboard < ApplicationRecord
    #same with user.rb, primary key shenanigans
    self.primary_key = '_id'

    has_many :entries
    has_many :users, through: :entries

    
end
