class AddAttachmentUploadedFileToFileProjects < ActiveRecord::Migration
  def self.up
    change_table :file_projects do |t|
      t.attachment :uploaded_file
    end
  end

  def self.down
    drop_attached_file :file_projects, :uploaded_file
  end
end
