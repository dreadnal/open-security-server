require 'rails_helper'

RSpec.describe SensorType, type: :model do
  it { should have_many(:sensors) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:icon) }
  it { should validate_presence_of(:model) }
  it { should validate_presence_of(:note) }
end