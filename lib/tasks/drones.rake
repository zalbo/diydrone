namespace :drones do
  desc "delete all article off drones"
  task delete: :environment do
    Drone.delete_all
  end

end
