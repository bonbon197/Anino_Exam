class Entry < ApplicationRecord

    belongs_to :user
    belongs_to :leaderboard
    validates :user_id, uniqueness: { scope: :leaderboard_id }
end
