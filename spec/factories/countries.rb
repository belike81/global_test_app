FactoryGirl.define do
  factory :country do
    country_code { Faker::Address.country_code }
    association :panel_provider
  end
end
