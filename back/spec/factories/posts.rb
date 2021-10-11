FactoryBot.define do
  factory :post do
    association :user
    title   { Faker::Book.title }
    content { Faker::Lorem.sentence }
  end
end
