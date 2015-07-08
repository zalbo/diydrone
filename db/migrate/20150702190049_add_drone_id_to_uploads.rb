class AddDroneIdToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :drone_id, :integer
  end
end
