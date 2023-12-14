class AddIndexes < ActiveRecord::Migration[7.1]
  def change
    add_index :reservations, :user_id
    add_index :reservations, :workspace_id
  end
end
