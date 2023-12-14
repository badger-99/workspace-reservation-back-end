class ChangeNullConstraint < ActiveRecord::Migration[7.1]
  def change
    change_column :reservations, :city, :string, null: false
    change_column :reservations, :start_date, :date, null: false
    change_column :reservations, :end_date, :date, null: false
    change_column :reservations, :user, :integer, null: false
    change_column :reservations, :workspace, :integer, null: false
  end
end
