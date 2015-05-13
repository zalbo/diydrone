class CreateDrones < ActiveRecord::Migration
  def change
    create_table :drones do |t|
      t.string :title
      t.string :user
      t.integer :tv_id
      t.string :tv_image , array: true

      t.timestamps null: false
    end
    add_index :drones, :tv_image, using: 'gin'
  end
end
