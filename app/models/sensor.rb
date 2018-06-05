class Sensor < SystemModule
  before_create :generate_api_key

  has_many :events
  belongs_to :sensor_type

  private

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end