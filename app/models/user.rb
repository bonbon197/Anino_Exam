class User < ApplicationRecord
    #I don't intend on using the _id as the primary key, but the json response is returning null for the _id field, so I'm setting it here
    self.primary_key = '_id'

    has_many :entries
    has_many :leaderboards, through: :entries

    validates :name, presence: true
end
