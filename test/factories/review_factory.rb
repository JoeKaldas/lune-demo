FactoryBot.define do
  factory :review do
    association :movie

    user { FFaker::Name.name }
    comment { FFaker::Lorem.sentence }
    rating { (0..5).to_a.sample }
  end
end
