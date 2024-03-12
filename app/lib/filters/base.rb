module Filters
  class Base
    attr_reader :sort, :scope

    delegate :result, to: :search

    def initialize(scope, params = {}, sort = nil)
      @scope  = scope
      @params = params
      @sort   = params.dig(:q, :s) || sort
    end

    def search
      @search ||= scope.ransack(search_params_adjusted)
    end

    def search_params
      @params.fetch(:q, s: @sort).permit(:s, :any_cont, *ransack_keys)
    end

    def to_params
      @params.permit(*keys, q: [:s, :any_cont, *ransack_keys]).merge(q: search_params)
    end

    # Override this if you need to manipulate the incoming search params; the original parameters
    # should not be modified directly since they might need to be re-used in their original form, e.g. for
    # a download link.
    def search_params_adjusted
      search_params
    end

    def ransack_keys
      []
    end

    def keys
      []
    end

    def has?(key)
      @params[key].present?
    end

    def active?
      keys.any? { |k| @params[k].present? } || ransack_keys.any? { |k| @params.dig(:q, k).present? }
    end
  end
end
