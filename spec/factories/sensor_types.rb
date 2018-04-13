FactoryBot.define do
  factory :sensor_type do
    name { Faker::Lorem.word }
    icon "default"
    model "default"
    note { Faker::Lorem.paragraph }
  end
end