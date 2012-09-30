Fabricator(:transaction) do
  charged_at { rand(10.years).ago }
  amount     { 100.0 * rand  }
  batch      { rand(99) }
  expiration { rand(10.years).ago }
  place_id   { Fabricate(:place).id } 
  card_id    { Fabricate(:card).id }  
end
