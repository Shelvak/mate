Fabricator(:advance) do
  charged_at { Time.zone.today } 
  detail     { Faker::Lorem.sentence(99) }
  amount     { 100.0 * rand }
  state      { [true, false].sample }
end
