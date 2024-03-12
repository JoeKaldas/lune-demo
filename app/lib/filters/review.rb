module Filters
  class Review < Base
    def ransack_keys
      %i[movie_id_eq]
    end

    def sort_fields
      %i[created_at]
    end
  end
end
