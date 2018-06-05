require 'rails_helper'

RSpec.describe Tracker, type: :model do
  it {expect(described_class).to be < SystemModule}

  it { should validate_presence_of(:address) }
end