# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "factory_bot"

if Rails.env.development?
  FactoryBot.create_list(:movie, 5)
  FactoryBot.create_list(:actor, 10)
  FactoryBot.create_list(:review, 10, movie_id: Movie.all.ids.sample)
end