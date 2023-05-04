class AddForeignKeyToEntries < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :entries, :users, column: :user_id, primary_key: :_id, on_delete: :cascade
  end
end
