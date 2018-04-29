class Sensor < ApplicationRecord
  has_many :events
  
  belongs_to :area
  belongs_to :sensor_type

  validates_presence_of :name, :address, :note, :api_key
end