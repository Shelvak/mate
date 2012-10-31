Fabricator(:card) do
  name      { Faker::Company.name }
  number    { (0..16).map { rand(9) }.join }
  expire_at { rand(1.year).from_now }
  bank_id   { Fabricate(:bank).id }
end
