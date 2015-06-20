class AddCulomnToFileProjects < ActiveRecord::Migration
  def change
    add_column :file_projects, :name, :string
    add_column :file_projects, :size, :string
    add_column :file_projects, :download, :string
  end
end
