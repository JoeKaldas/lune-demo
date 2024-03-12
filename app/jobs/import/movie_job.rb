module Import
  class MovieJob < ApplicationJob
    def perform(data)
      data.each do |record|
        movie = Movie.find_or_initialize_by(name: record[:movie], year: record[:year], director: record[:director])
        movie.description = record[:description]
        movie.save

        create_and_assign_actor(movie, record[:actor])
        create_and_assign_location(movie, record[:city], record[:country])
      rescue StandardError => e
        puts "======== #{e.message}"
      end
      broadcast_reload
    end

    private

    def create_and_assign_actor(movie, actor_name)
      actor = Actor.find_or_create_by(name: actor_name)
      movie.actors << actor unless actor.id.in?(movie.actor_ids)
    end

    def create_and_assign_location(movie, city, country)
      location = Location.find_or_create_by(city:, country:)
      movie.locations << location unless location.id.in?(movie.location_ids)
    end

    def broadcast_reload
      template = "<meta data-controller='reload'/>"
      Turbo::StreamsChannel.broadcast_replace_to(
        "movies-list",
        target: "records_listing",
        content: template
      )
    end
  end
end
