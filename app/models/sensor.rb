class Sensor < ApplicationRecord
  before_save :generate_api_key

  has_many :events
  
  belongs_to :area
  belongs_to :sensor_type

  validates_presence_of :name, :address, :note

  private

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64 if self.api_key.nil?
  end
end