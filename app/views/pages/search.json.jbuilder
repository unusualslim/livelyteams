json.cases do
  json.array!(@cases) do |c|
    json.name c.subject
    json.url case_path(c)
  end
end

json.locations do
  json.array!(@locations) do |location|
    json.name location.name
    json.url location_path(location)
  end
end
