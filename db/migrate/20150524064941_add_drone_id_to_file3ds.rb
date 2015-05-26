class AddDroneIdToFile3ds < ActiveRecord::Migration
  def change
    add_column :file3ds, :drone_id, :integer
  end
end
