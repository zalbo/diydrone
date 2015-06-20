class FileProject < ActiveRecord::Base
  has_attached_file :enclosure
  do_not_validate_attachment_file_type :enclosure
  belongs_to :drone


#  do_not_validate_attachment_file_type :enclosure
end
