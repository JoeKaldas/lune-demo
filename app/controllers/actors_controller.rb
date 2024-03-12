class ActorsController < ApplicationController
  include Pagy::Backend

  def index
    @total = scope.size
    @pagy, @actors = pagy(filter.result, items: 10)
  end

  private

  def scope
    @scope ||= Actor.all
  end

  def filter
    @filter ||= ::Filters::Actor.new(scope, params, "name asc")
  end
end
