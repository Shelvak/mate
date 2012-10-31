Fabricator(:job_area) do
  job_area  { Faker::Lorem.sentence }
  provider_id  { Fabricate(:provider).id }
end
