class MoviesController < ApplicationController
  include Pagy::Backend

  def index
    @total = scope.size
    @pagy, @movies = pagy(filter.result, items: 10)
  end

  def import
    
  end

  private

  def scope
    @scope ||= Movie.all
  end

  def filter
    @filter ||= ::Filters::Movie.new(scope, params, "name asc")
  end
end
