class Floor < ApplicationRecord
    has_many :areas

    validates_presence_of :name, :position
end