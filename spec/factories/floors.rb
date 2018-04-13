FactoryBot.define do
  factory :floor do
    area_id nil

    name { Faker::Lorem.word }
    position { Faker::Number.between(1, 1000) }
    note { Faker::Lorem.paragraph }
  end
end