FactoryBot.define do
  factory :camera do
    area_id nil
  
    name { Faker::Lorem.word }
    address "127.0.0.1"
    note { Faker::Lorem.paragraph }
  end
end