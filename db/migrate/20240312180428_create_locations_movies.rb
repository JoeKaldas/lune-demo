class CreateLocationsMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :locations_movies, id: false do |t|
      t.bigint :location_id, null: false
      t.bigint :movie_id, null: false
    end

    add_index :locations_movies, %i[movie_id location_id], unique: true, name: "index_locations_movies"
  end
end
