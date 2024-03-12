module Filters
  class Movie < Base
    def sort_fields
      %i[name created_at]
    end
  end
end
