class Device < ApplicationRecord
  before_create :generate_data

  validates_presence_of :name

  def verify(one_time_password) 
    return nil if self.verified || self.one_time_password != one_time_password 
    self.verified = true 
    self.api_key = SecureRandom.urlsafe_base64 
    self.save! 
    return self.api_key 
  end 

  private

  def generate_data
    self.verified = false
    self.one_time_password = SecureRandom.urlsafe_base64
  end
end