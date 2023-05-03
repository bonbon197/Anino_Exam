class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :score
      t.integer :rank
      t.string :name
      t.references :user, foreign_key: true
      t.references :leaderboard, foreign_key: true

      t.timestamps
    end
  end
end
