class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.string :city
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true, index: true
      t.references :workspace, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
