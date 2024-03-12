class Review < ApplicationRecord
  FILE_TYPES = %w[
    application/vnd.ms-excel
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
    text/csv
  ].freeze

  after_save :update_movie_rating

  normalizes :user, with: -> { _1.strip }
  normalizes :comment, with: -> { _1.strip || "" }, apply_to_nil: true

  belongs_to :movie

  ransack_alias :any, :user

  scope :for_listing, -> { includes(:movie) }

  private

  def update_movie_rating
    movie.update(rating: movie.reviews.average(:rating))
  end
end
