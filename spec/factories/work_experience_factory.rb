FactoryBot.define do
  factory :work_experience do
    company_name { Faker::Lorem.word }
    company_location { Faker::Lorem.word }
    start_date { Time.now - 1.day }
    end_date { Time.now }
    job_title { Faker::Lorem.word }
    description { Faker::Lorem.word }
  end
end
