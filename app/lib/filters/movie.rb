module Filters
  class Movie < Base
    def ransack_keys
      %i[locations_id_eq]
    end

    def sort_fields
      %i[name rating created_at]
    end
  end
end
