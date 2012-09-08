Fabricator(:movement) do
  charged_at   { Time.zone.today }
  mov_number   { rand(9999999999999) }
  amount       { rand(99999999999) }
  total_amount { rand(9999) }
  comment      { Faker::Lorem.sentences(99) }
  devoted      { Faker::Lorem.sentence }
  deposited_in { Faker::Lorem.sentence }
  devoted_at   { Time.zone.today }
  code_id      { rand(99) }
  bank_id      { rand(99) }
  client_id    { rand(99) }
end
