class SystemModule < ApplicationRecord
  belongs_to :area

  validates_presence_of :name
  validates_presence_of :position_x
  validates_presence_of :position_y
  validates_presence_of :position_z
  validates_presence_of :rotation_x
  validates_presence_of :rotation_y
  validates_presence_of :rotation_z

  scope :cameras, -> { where(type: "Camera") }
  scope :sensors, -> { where(type: "Sensor") }
  scope :trackers, -> { where(type: "Tracker") }
end