json.array!(@drones) do |drone|
  json.extract! drone, :id, :title, :user
  json.url drone_url(drone, format: :json)
end
