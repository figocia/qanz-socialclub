Fabricator(:user) do
  email { Faker::Internet.email }  
  name { Faker::Name.name } 
  password {'12345'}
end

Fabricator(:member, from: :user) do
  is_member true
end

Fabricator(:admin, from: :user) do
  is_admin true
end

Fabricator(:participant, from: :user) 