class AddUniqueIndexToWorkspaceNameColumn < ActiveRecord::Migration[7.1]
  def change
    add_index :workspaces, :name, unique: true
  end
end
