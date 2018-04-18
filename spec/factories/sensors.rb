FactoryBot.define do
  factory :sensor do
    area_id nil
    sensor_type_id nil

    name { Faker::Lorem.word }
    address "127.0.0.1"
    note { Faker::Lorem.paragraph }
    data { Faker::Lorem.paragraph }
    api_key {SecureRandom.urlsafe_base64}
  end
end