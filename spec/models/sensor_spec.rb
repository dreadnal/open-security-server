require 'rails_helper'

RSpec.describe Sensor, type: :model do
  it {should belong_to(:area)}
  it {should belong_to(:sensor_type)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:note) }
  it { should validate_presence_of(:data) }
end