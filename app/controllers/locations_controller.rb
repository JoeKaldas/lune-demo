class LocationsController < ApplicationController
  include Pagy::Backend

  def index
    @total = scope.size
    @pagy, @locations = pagy(filter.result, items: 10)
  end

  private

  def scope
    @scope ||= Location.all
  end

  def filter
    @filter ||= ::Filters::Location.new(scope, params, "city asc, country asc")
  end
end
