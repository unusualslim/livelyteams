json.locations do
  json.array!(@locations) do |location|
    json.id location.id
    json.name location.name
    json.url location_path(location)
  end
end
