class AddUniqueConstraintToReservations < ActiveRecord::Migration[7.1]
  def change
    add_index :reservations, [:workspace_id, :start_date, :city], unique: true, name: 'index_reservations_on_workspace_start_date_city'
    add_index :reservations, [:workspace_id, :end_date, :city], unique: true, name: 'index_reservations_on_workspace_end_date_city'
  end
end
