class CreateFile3ds < ActiveRecord::Migration
  def change
    create_table :file3ds do |t|
      t.string :name
      t.string :size
      t.string :link
      t.string :download
      t.string :image , array: true

      t.timestamps null: false
    end
    add_index :file3ds, :image, using: 'gin'
  end
end
