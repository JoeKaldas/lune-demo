class Actor < ApplicationRecord
  before_update :sync_full_name

  normalizes :first_name, :last_name, :full_name, with: ->(attribute) { attribute.strip }

  has_and_belongs_to_many :movies

  private

  def sync_full_name
    self.full_name = [first_name, last_name].compact.join(" ")
  end
end
