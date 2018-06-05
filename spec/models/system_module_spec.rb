require 'rails_helper'

RSpec.describe SystemModule, type: :model do
  it {should belong_to(:area)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:position_x) }
  it { should validate_presence_of(:position_y) }
  it { should validate_presence_of(:position_z) }
  it { should validate_presence_of(:rotation_x) }
  it { should validate_presence_of(:rotation_y) }
  it { should validate_presence_of(:rotation_z) }
end