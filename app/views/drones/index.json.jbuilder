json.array!(@drones) do |drone|
  json.extract! drone, :id, :title, :tv_user
  json.url drone_url(drone, format: :json)
end
