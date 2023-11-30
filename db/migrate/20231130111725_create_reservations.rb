class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.string :city
      t.date :start_date
      t.date :end_date
      t.integer :user
      t.integer :workspace

      t.timestamps
    end
  end
end
