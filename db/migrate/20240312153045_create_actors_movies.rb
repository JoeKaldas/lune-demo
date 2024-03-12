class CreateActorsMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :actors_movies, id: false do |t|
      t.bigint :movie_id, null: false
      t.bigint :actor_id, null: false
    end

    add_index :actors_movies, %i[movie_id actor_id], unique: true, name: "index_actors_movies"
  end
end
