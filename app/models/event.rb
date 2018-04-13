class Event < ApplicationRecord
  belongs_to :event_type
  belongs_to :sensor

  validates_presence_of :state
end