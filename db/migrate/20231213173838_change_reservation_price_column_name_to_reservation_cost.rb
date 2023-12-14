class ChangeReservationPriceColumnNameToReservationCost < ActiveRecord::Migration[7.1]
  def change
    rename_column :reservations, :reservation_price, :reservation_cost
  end
end
