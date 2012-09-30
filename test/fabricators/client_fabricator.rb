Fabricator(:client) do
  name          { Faker::Name.name }
  phone         { Faker::PhoneNumber.phone_number }
  email         { Faker::Internet.email }
  website       { Faker::Internet.domain_name }
  ident         { |attrs| "#{attrs[:name]} #{Faker::Lorem.words.first}" }
  workplace_id  { Fabricate(:workplace).id }
end
