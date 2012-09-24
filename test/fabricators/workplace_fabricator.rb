Fabricator(:workplace) do
  address   { Faker::Address.street_address }
  city      { Faker::Address.city }
  state     { Faker::Address.state }
  country   { ['Argentina','Chile','Brasil'].sample }
end
