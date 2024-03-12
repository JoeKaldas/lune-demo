FactoryBot.define do
  factory :location do
    city { FFaker::Address.city }
    country { FFaker::Address.country }
  end
end
