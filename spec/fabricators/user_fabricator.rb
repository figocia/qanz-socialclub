Fabricator(:user) do
  email { Faker::Internet.email }  
  name { Faker::Name.name } 
end

Fabricator(:member, from: :user) do
  is_member true
end