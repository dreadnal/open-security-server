class SensorType < ApplicationRecord
    has_many :sensors
  
    validates_presence_of :name
  end