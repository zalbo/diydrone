class Drone < ActiveRecord::Base
  has_many :file_projects, dependent: :destroy
  has_many :uploads , dependent: :destroy



end
