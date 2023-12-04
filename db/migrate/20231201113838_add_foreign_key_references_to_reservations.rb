class AddForeignKeyReferencesToReservations < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :reservations, :users, column: :user_id
    add_foreign_key :reservations, :workspaces, column: :workspace_id
  end
end
