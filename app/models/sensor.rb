class Sensor < ApplicationRecord
  belongs_to :area
  belongs_to :sensor_type

  validates_presence_of :name, :address, :note, :data, :api_key
end