require 'rails_helper'

RSpec.describe Area, type: :model do
  it {should have_many(:cameras)}
  it {should have_many(:sensors)}
  it {should have_many(:trackers)}
  it {should have_many(:system_modules)}

  it {should belong_to(:floor)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:verticles) }
end
