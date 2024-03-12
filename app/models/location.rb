class Location < ApplicationRecord
  normalizes :city, :country, with: ->(attribute) { attribute.strip }

  has_and_belongs_to_many :movies

  ransack_alias :any, :city_or_country
end
