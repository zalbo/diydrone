class AddColumnFromtvToDrone < ActiveRecord::Migration
  def change
    add_column :drones, :fromtv, :boolean
  end
end
