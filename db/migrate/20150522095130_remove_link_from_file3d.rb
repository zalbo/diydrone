class RemoveLinkFromFile3d < ActiveRecord::Migration
  def change
    remove_column :file3ds, :link, :datatype
  end
end
