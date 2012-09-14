Fabricator(:bank) do
  name    { Faker::Name.first_name }
  website { Faker::Internet.domain_name }
  amount  { 100.0 * rand }
end
