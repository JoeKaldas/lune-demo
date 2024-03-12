module Filters
  class Movie < Base
    def sort_fields
      %i[name rating created_at]
    end
  end
end
