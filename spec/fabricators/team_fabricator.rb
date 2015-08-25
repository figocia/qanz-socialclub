Fabricator(:team) do
  competition
  name { Faker::Name.name }
end

