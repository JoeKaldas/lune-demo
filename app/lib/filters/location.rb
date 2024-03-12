module Filters
  class Location < Base
    def sort_fields
      %i[created_at]
    end
  end
end
