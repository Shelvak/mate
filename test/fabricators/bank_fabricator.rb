Fabricator(:bank) do
  name    { Faker::Company.name }
  website { Faker::Internet.domain_name }
  amount  { 100.0 * rand }
end
