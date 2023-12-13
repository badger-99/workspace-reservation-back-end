class AddNullConstraintToReservationsReservationPriceColumn < ActiveRecord::Migration[7.1]
  def change
    change_column :reservations, :reservation_price, :float, null: false
  end
end
