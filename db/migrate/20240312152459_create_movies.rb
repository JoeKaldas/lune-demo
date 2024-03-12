class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :year, null: false
      t.string :director, null: false
      t.decimal :rating, null: false, default: 0
      t.timestamps
    end
  end
end
