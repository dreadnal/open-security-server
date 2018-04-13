class Area < ApplicationRecord
  has_many :cameras
  has_many :sensors

  belongs_to :floor

  validates_presence_of :name, :data
end