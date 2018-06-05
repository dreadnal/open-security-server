class Preference < ApplicationRecord
  validates_presence_of :key, :value
end