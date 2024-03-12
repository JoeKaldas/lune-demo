module Import
  class MovieJob < ApplicationJob
    def perform(data)
      data.each do |record|
        Movie.find_or_initialize_by(name: record[:movie], year: record[:year], director: record[:director]).update(description: record[:description])
      rescue StandardError => e
        puts "======== #{e.message}"
      end
      broadcast_reload
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
