require 'rails_helper'

RSpec.describe Sensor, type: :model do
  it {expect(described_class).to be < SystemModule}
  
  it { should have_many(:events) }
  it { should belong_to(:sensor_type) }
end