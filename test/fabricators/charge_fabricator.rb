Fabricator(:charge) do
  charged_at { Time.zone.today } 
  detail     { Faker::Lorem.sentence }
  amount     { 100.0 * rand }
  state      { [true, false].sample }
end
