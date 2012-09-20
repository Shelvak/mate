Fabricator(:code) do
  number { rand(99) }
  detail { Faker::Lorem.sentence }
end
