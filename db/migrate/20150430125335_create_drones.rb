class CreateDrones < ActiveRecord::Migration
  def change
    create_table :drones do |t|
      t.string :title
      t.string :tv_user

      t.timestamps null: false
    end
  end
end
