class Drone < ActiveRecord::Base
  has_many :file3ds , dependent: :destroy
  has_many :file_projects, dependent: :destroy



end
