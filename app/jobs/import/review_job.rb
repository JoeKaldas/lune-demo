module Import
  class ReviewJob < ApplicationJob
    def perform(data)
      data.each do |record|
        movie = Movie.find_by(name: record[:movie])
        next unless movie

        Review.find_or_initialize_by(movie:, user: record[:user]).update(rating: record[:rating], comment: record[:comment])
      rescue StandardError => e
        puts "======== #{e.message}"
      end
      broadcast_reload
    end

    def broadcast_reload
      template = "<meta data-controller='reload'/>"
      Turbo::StreamsChannel.broadcast_replace_to(
        "reviews-list",
        target: "records_listing",
        content: template
      )
    end
  end
end
