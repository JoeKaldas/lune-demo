Ransack.configure do |config|
  config.custom_arrows = {
    up_arrow: '<i class="fas fa-caret-up"></i>',
    down_arrow: '<i class="fas fa-caret-down"></i>'
  }
end

class Arel::Table
  def table_name
    name
  end
end