class MoviesController < ApplicationController
  include Pagy::Backend

  def index
    @total = scope.size
    @pagy, @movies = pagy(filter.result, items: 10)
  end

  def import
    spreadsheet = ::Roo::Spreadsheet.open(params[:file].path)
    data = []
    (2..spreadsheet.last_row).each do |i|
      movie, description, year, director, actor, city, country = spreadsheet.row(i).values_at(0..6)
      movie_data = { movie:, description:, year:, director:, actor:, city:, country: }

      if movie_data.values.any?(&:nil?)
        flash[:alert] = "Your sheet contains invalid data"
        return redirect_to movies_path
      end

      data.push(movie_data)
    end
    Import::MovieJob.perform_later(data)

    flash[:notice] = "Your movies are being uploaded"
    redirect_to movies_path
  end

  private

  def scope
    @scope ||= Movie.all
  end

  def filter
    @filter ||= ::Filters::Movie.new(scope, params, "name asc")
  end
end
