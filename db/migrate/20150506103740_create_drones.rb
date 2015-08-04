class CreateDrones < ActiveRecord::Migration
  def change
    create_table :drones do |t|
      t.string :title
      t.string :user
      t.string :image , array: true


      t.timestamps null: false
    end
    add_index :drones, :image, using: 'gin'
  end
end
