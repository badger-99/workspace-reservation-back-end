class AlterWorkspaceTableToRemoveImageColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :workspaces, :image, :string
  end
end
