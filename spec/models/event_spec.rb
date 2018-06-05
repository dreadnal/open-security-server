require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:event_type) }
  it { should belong_to(:sensor) }

  it { should validate_presence_of(:state) }
end