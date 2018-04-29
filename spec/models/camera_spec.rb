require 'rails_helper'

RSpec.describe Camera, type: :model do
  it {should belong_to(:area)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:note) }
end