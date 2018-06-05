class EventType < ApplicationRecord
    has_many :events

    validates_presence_of :name, :ref_name
end