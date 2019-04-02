FactoryBot.define do
  factory :user do
    name{Faker::Name.name}
    email{Faker::Internet.email}
    trait :unavailable do
      archived_at{Time.zone.now}
    end
  end
end
