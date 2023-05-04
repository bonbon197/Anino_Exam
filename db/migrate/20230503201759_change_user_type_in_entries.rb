class ChangeUserTypeInEntries < ActiveRecord::Migration[5.2]
  def up
    # Step 1: create new uuid column
    add_column :entries, :new_user_id, :uuid

    # Step 2: copy values from bigint column to uuid column
    Entry.all.each do |entry|
      entry.update(new_user_id: entry.user_id)
    end

    # Step 3: remove the old user_id column
    remove_column :entries, :user_id

    # Step 4: rename the new uuid column to user_id
    rename_column :entries, :new_user_id, :user_id
  end

  def down
    # Revert the changes made in the up method
    add_column :entries, :old_user_id, :bigint

    Entry.all.each do |entry|
      entry.update(old_user_id: entry.user_id)
    end

    remove_column :entries, :user_id

    rename_column :entries, :old_user_id, :user_id
  end
end
