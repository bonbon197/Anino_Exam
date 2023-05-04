class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :score
      t.integer :rank
      t.string :name
      t.uuid :user_id
      t.uuid :leaderboard_id

      
      t.timestamps
    end
  end
end
