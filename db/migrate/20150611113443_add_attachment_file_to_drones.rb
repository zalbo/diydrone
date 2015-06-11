class AddAttachmentFileToDrones < ActiveRecord::Migration
  def self.up
    change_table :drones do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :drones, :file
  end
end
