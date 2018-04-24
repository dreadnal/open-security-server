class Device < ApplicationRecord
    validates_presence_of :name, :api_key
end
