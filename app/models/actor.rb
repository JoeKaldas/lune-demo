class Actor < ApplicationRecord
  normalizes :name, with: ->(attribute) { attribute.strip }

  has_and_belongs_to_many :movies

  ransack_alias :any, :name
end
