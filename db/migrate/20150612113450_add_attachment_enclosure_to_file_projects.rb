class AddAttachmentEnclosureToFileProjects < ActiveRecord::Migration
  def self.up
    change_table :file_projects do |t|
      t.attachment :enclosure
    end
  end

  def self.down
    remove_attachment :file_projects, :enclosure
  end
end
