namespace :drones do
  desc "delete all article off drones"
  task delete: :environment do
    Drone.delete_all
  end

  desc "Test insert one project"
  task insert: :environment do
    Drone.create(title: "title test", user: "user test")
  end

end
