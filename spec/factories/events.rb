FactoryBot.define do
  factory :event do
    event_type_id nil
    sensor_id nil
        
    state "unread"
  end
end