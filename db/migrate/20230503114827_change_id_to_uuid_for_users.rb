class ChangeIdToUuidForUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :_id, :uuid, default: 'gen_random_uuid()', unique: true
  end

  def down
    change_column :users, :_id, :string
  end
end
