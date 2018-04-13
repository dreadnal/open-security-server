FactoryBot.define do
  factory :event_type do
    name { Faker::Lorem.word }
    icon "default"
  end
end