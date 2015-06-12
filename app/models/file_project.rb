class FileProject < ActiveRecord::Base
  belongs_to :drone , dependent: :destroy
  has_attached_file :file_project

  attr_accessor :file_project_file_name
  do_not_validate_attachment_file_type :file_project
end
