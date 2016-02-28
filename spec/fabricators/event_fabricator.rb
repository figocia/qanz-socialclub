Fabricator(:event) do
  name { "Social club Lunch" }
  address { "New York, NY" }
  time { Faker::Date.forward(23) }
  description { Faker::Lorem.paragraph }
  member_only { false }
  is_confirmed { false}  
end

