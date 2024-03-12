class Location < ApplicationRecord
  normalizes :city, :country, with: ->(attribute) { attribute.strip }
end
