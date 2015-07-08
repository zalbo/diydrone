class Upload < ActiveRecord::Base
  belongs_to :drone
  has_attached_file :uploaded_file, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :uploaded_file,
content_type: [
"image/jpg",
"image/jpeg",
"image/png",
"image/gif"]

end
