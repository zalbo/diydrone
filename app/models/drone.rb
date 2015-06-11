class Drone < ActiveRecord::Base
  has_many :file3ds , dependent: :delete_all

  has_attached_file :file
end
