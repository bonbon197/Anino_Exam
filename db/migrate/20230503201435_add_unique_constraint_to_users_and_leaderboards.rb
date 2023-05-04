class AddUniqueConstraintToUsersAndLeaderboards < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :_id, unique: true
    add_index :leaderboards, :_id, unique: true
  end
end
