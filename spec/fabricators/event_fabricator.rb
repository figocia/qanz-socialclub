Fabricator(:event) do
  name { "Social club Lunch" }
  address { Faker::Address.street_name }
  time { Faker::Date.forward(23) }
  description { Faker::Lorem.paragraphs }
  
end

