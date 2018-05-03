require 'securerandom'

class Device < ApplicationRecord
  before_save :default_values
  
  validates_presence_of :name

  def verify(one_time_password)
    return nil if self.verified || self.one_time_password != one_time_password
    self.verified = true
    self.api_key = SecureRandom.urlsafe_base64
    self.save!
    return self.api_key
  end

  private

  def default_values
    self.verified = false if self.verified.nil?
    self.one_time_password = SecureRandom.urlsafe_base64 if self.one_time_password.nil?
  end
end
