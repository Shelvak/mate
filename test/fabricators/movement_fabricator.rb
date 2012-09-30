Fabricator(:movement) do
  charged_at   { Time.zone.today }
  mov_number   { 100 * rand }
  amount       { 100 * rand }
  total_amount { 100 * rand }
  comment      { Faker::Lorem.sentences(99) }
  devoted      { Faker::Lorem.sentence }
  deposited_in { Faker::Lorem.sentence }
  devoted_at   { Time.zone.today }
  code_id      { Fabricate(:code).id }
  bank_id      { Fabricate(:bank).id }
  client_id    { Fabricate(:client).id }
end
