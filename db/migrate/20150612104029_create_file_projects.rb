class CreateFileProjects < ActiveRecord::Migration
  def change
    create_table :file_projects do |t|
      t.string :image , array: true

      t.timestamps null: false
    end
    add_index :file_projects, :image, using: 'gin'
  end
end
