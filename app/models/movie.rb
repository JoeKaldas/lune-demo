class Movie < ApplicationRecord
  DESCRIPTION_MAX = 1000

  ransack_alias :any, :name

  normalizes :name, with: ->(name) { name.strip }
  normalizes :description, with: -> { _1.presence || "" }, apply_to_nil: true

  has_and_belongs_to_many :actors
end
