Fabricator(:workplace) do
  address   { Faker::Address.street_address }
  city      { Faker::Address.city }
  state     { Faker::Address.state }
  country   { ['Argentina','Chile','Brasil'].sample }
  client_id { rand(99) }
end
