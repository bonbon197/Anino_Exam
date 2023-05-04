class UpdateEntriesTable < ActiveRecord::Migration[5.2]
  def up
    # Create temporary columns
    add_column :entries, :tmp_user_id, :uuid
    add_column :entries, :tmp_leaderboard_id, :uuid

    # Remove the old columns
    remove_column :entries, :user_id
    remove_column :entries, :leaderboard_id

    # Rename the temporary columns
    rename_column :entries, :tmp_user_id, :user_id
    rename_column :entries, :tmp_leaderboard_id, :leaderboard_id
  end

  def down
    # Revert the changes by recreating the original columns with the bigint type
    add_column :entries, :tmp_user_id, :bigint
    add_column :entries, :tmp_leaderboard_id, :bigint

    # Remove the UUID columns
    remove_column :entries, :user_id
    remove_column :entries, :leaderboard_id

    # Rename the temporary columns
    rename_column :entries, :tmp_user_id, :user_id
    rename_column :entries, :tmp_leaderboard_id, :leaderboard_id
  end
end
