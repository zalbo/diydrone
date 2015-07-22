namespace :drones do
  desc "destroy all article off drones"
  task delete: :environment do
    Drone.all.destroy_all
  end

  desc "Test insert one project"
  task insert: :environment do
    Drone.create(title: "title test", user: "user test")
  end

end
