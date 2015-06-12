class CreateFileProjects < ActiveRecord::Migration
  def change
    create_table :file_projects do |t|

      t.timestamps null: false
    end
  end
end
