class AddAttachmentEnclosureToDrones < ActiveRecord::Migration
  def self.up
    change_table :drones do |t|
      t.attachment :enclosure
    end
  end

  def self.down
    remove_attachment :drones, :enclosure
  end
end
