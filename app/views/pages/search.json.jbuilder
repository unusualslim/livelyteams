json.cases do
  json.array!(@cases) do |case|
    json.name case.subject
    json.url case_path(case)
  end
end

json.locations do
  json.array!(@locations) do |location|
    json.name location.name
    json.url location_path(location)
  end
end
