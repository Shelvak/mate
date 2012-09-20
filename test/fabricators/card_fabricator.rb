Fabricator(:card) do
  name    { Faker::Company.name }
  address { Faker::Address.street_address }
  website { Faker::Internet.domain_name }
end
