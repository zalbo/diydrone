class Drone < ActiveRecord::Base
  has_many :file_projects, dependent: :destroy

  has_attached_file :enclosure
  validates_attachment_content_type :enclosure

end
