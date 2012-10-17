Fabricator(:code) do
  number { rand(10000) }
  detail { Faker::Lorem.sentence }
end
