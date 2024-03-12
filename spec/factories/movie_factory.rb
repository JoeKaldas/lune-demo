FactoryBot.define do
  factory :movie do
    name { FFaker::Movie.title }
    description { FFaker::Book.description }
    year { FFaker::Vehicle.year }
  end
end
