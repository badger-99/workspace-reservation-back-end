class RenameReservationForeignKeyColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :reservations, :user, :user_id
    rename_column :reservations, :workspace, :workspace_id
  end
end
