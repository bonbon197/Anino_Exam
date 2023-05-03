class CreateLeaderboards < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto'
    create_table :leaderboards do |t|
      t.string :name,           null: false, default: ""
      t.uuid :_id,              null: false, default: 'gen_random_uuid()', unique: true

      

      t.timestamps
    end
  end
end
