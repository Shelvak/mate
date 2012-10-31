Fabricator(:bank) do
  name          { Faker::Company.name }
  website       { Faker::Internet.domain_name }
  phone         { Faker::PhoneNumber.phone_number }
  address       { Faker::Address.street_address }
  contact_name  { Faker::Name.name }
end
