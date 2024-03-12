module Constants
  CSV_EMPTY_LINE_REGEXP = /^(?:,\s*)+$/

  # Excel Byte Order Mark (BOM) -- see for example
  # https://estl.tech/of-ruby-and-hidden-csv-characters-ef482c679b35
  EXCEL_BOM = "\xEF\xBB\xBF".freeze
end
