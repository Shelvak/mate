Fabricator(:cash) do
  amount  { 100.0 * rand }
  detail  { Faker::Lorem.sentence }
  flow_id { Fabricate(:flow).id }
end
