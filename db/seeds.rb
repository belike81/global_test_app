# Generate a default token
Tokenizer.generate_token

#Panel providers & Countries
3.times do |i|
  panel = PanelProvider.create(code: i+1)
  Country.create(country_code: Faker::Address.country_code, panel_provider: panel)
end


# Location group & Target group
PanelProvider.all.each do |panel|
  LocationGroup.create(name: Faker::Address.city, country: panel.country, panel_provider: panel)
  TargetGroup.create(name: Faker::Address.city, panel_provider: panel, countries: [panel.country])
end

panel = PanelProvider.last
LocationGroup.create(name: Faker::Address.city, country: panel.country, panel_provider: panel)
TargetGroup.create(name: Faker::Address.city, panel_provider: panel, countries: [panel.country])

# Nested target groups
TargetGroup.all.each do |target_group|
  parent = target_group
  3.times do
    parent = TargetGroup.create(name: Faker::Address.city, parent_id: parent.id, panel_provider: parent.panel_provider)
  end
end

# Locations
LocationGroup.all.each do |location|
  5.times do
    Location.create(name: Faker::Address.city, location_groups: [location])
  end
end
