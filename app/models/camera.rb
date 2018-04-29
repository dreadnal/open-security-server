class Camera < ApplicationRecord
  belongs_to :area

  validates_presence_of :name, :address, :note
end