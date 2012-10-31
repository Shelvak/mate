Fabricator(:provider) do
  name            { Faker::Name.name }
  firm_name       { Faker::Company.name }
  phone           { Faker::PhoneNumber.phone_number }
  email           { Faker::Internet.email }
  address         { Faker::Address.street_address }
  ident           { |attrs| "#{attrs[:name]} #{Faker::Lorem.words.first}" }
  iva_responsive  { Client::IVA_KINDS.values.sample }
end
