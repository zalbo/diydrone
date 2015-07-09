class Upload < ActiveRecord::Base
  belongs_to :drone
  has_attached_file :uploaded_file,
  :styles => {
    :thumb => "100x100#",
    :small  => "150x150>",
    :medium => "200x200" }
  validates_attachment_content_type :uploaded_file,
content_type: [
"image/jpg",
"image/jpeg",
"image/png",
"image/gif"]

end
