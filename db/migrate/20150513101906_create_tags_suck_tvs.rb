class CreateTagsSuckTvs < ActiveRecord::Migration
  def change
    create_table :tags_suck_tvs do |t|
      t.string :tag

      t.timestamps null: false
    end
  end
end
