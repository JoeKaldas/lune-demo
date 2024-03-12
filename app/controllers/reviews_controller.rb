class ReviewsController < ApplicationController
  include Pagy::Backend

  def index
    @total = scope.size
    @pagy, @reviews = pagy(filter.result.for_listing, items: 10)
  end

  private

  def scope
    @scope ||= Review.all
  end

  def filter
    @filter ||= ::Filters::Review.new(scope, params, "created_at desc")
  end
end
