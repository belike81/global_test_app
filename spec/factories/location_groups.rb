FactoryGirl.define do
  factory :location_group do
    name { Faker::Address.city }
    association :panel_provider
    association :country
  end
end
