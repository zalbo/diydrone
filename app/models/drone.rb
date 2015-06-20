class Drone < ActiveRecord::Base
  has_many :file_projects, dependent: :destroy



end
