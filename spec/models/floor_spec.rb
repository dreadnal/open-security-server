require 'rails_helper'

RSpec.describe Floor, type: :model do
  it { should have_many(:areas) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:position) }
end