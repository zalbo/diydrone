class AddDroneIdToFileProject < ActiveRecord::Migration
  def change
    add_column :file_projects, :drone_id, :integer
  end
end
