class ReviewsController < ApplicationController
  include Pagy::Backend

  def index
    @total = scope.size
    @pagy, @reviews = pagy(filter.result.for_listing, items: 10)
  end

  def import
    spreadsheet = ::Roo::Spreadsheet.open(params[:file].path)
    data = []
    (2..spreadsheet.last_row).each do |i|
      movie, user, rating, comment = spreadsheet.row(i).values_at(0..4)
      data.push({ movie:, user:, rating:, comment: })
    end
    Import::ReviewJob.perform_later(data)

    flash[:notice] = "Your reviews are being uploaded"
    redirect_to reviews_path
  end

  private

  def scope
    @scope ||= Review.all
  end

  def filter
    @filter ||= ::Filters::Review.new(scope, params, "created_at desc")
  end
end
