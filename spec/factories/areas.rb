FactoryBot.define do
  factory :area do
    floor_id nil

    name { Faker::Lorem.word }
  end
end