class Area < ApplicationRecord
  has_many :cameras
  has_many :sensors
  has_many :trackers
  has_many :system_modules

  belongs_to :floor

  validates_presence_of :name, :verticles
end