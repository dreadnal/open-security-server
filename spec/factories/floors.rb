FactoryBot.define do
  factory :floor do
    name { Faker::Lorem.word }
    position { Faker::Number.between(1, 1000) }
    data { Faker::Lorem.paragraph }
  end
end