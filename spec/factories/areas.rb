FactoryBot.define do
  factory :area do
    floor_id nil

    name { Faker::Lorem.word }
    data { Faker::Lorem.paragraph }
  end
end