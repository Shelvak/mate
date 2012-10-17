Fabricator(:flow) do |f|
  f.code          { rand(1000) }
  f.subcode       { rand(1000).to_s + Faker::Lorem.word }
  f.charged_at    { rand(1.year).ago }
  f.detail        { Faker::Lorem.sentence }
  f.receipt       { 100 * rand }
  f.register      { 100 * rand }
  f.total_amount  { 100.0 * rand }
  f.in            { [true, false].sample }
end
