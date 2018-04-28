FactoryBot.define do
    factory :device do
  
      name { Faker::Lorem.word }
      api_key {SecureRandom.urlsafe_base64}
    end
  end