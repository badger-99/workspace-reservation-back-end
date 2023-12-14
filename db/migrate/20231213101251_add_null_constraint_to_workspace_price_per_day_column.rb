class AddNullConstraintToWorkspacePricePerDayColumn < ActiveRecord::Migration[7.1]
  def change
    change_column :workspaces, :price_per_day, :float, null: false
  end
end
