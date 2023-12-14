class AddPricePerDayColumnToWorkspaces < ActiveRecord::Migration[7.1]
  def change
    add_column :workspaces, :price_per_day, :float
    Workspace.update_all(price_per_day: 0.00)
  end
end
