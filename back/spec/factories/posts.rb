FactoryBot.define do
  factory :post do
    association :user
    content { Faker::Lorem.sentence }
    study_time { '0:10' }
    study_date { Time.current }
  end
end
