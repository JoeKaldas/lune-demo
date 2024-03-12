class Review < ApplicationRecord
  normalizes :user, with: -> { _1.strip }
  normalizes :comment, with: -> { _1.strip || "" }, apply_to_nil: true

  belongs_to :movie

  ransack_alias :any, :user

  scope :for_listing, -> { includes(:movie) }
end
