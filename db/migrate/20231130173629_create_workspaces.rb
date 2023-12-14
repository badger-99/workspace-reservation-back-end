class CreateWorkspaces < ActiveRecord::Migration[7.1]
  def change
    create_table :workspaces do |t|
      t.text :name, null:false
      t.text :description, null:false
      t.text :image, null:false

      t.timestamps
    end
  end
end
