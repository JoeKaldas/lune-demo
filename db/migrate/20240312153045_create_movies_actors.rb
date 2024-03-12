class CreateMoviesActors < ActiveRecord::Migration[7.1]
  def change
    create_table :movies_actors, id: false do |t|
      t.bigint :movie_id, null: false
      t.bigint :actor_id, null: false
    end

    add_index :movies_actors, %i[movie_id actor_id], unique: true, name: "index_movies_actors"
  end
end
