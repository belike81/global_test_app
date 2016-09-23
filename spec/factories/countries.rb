FactoryGirl.define do
  factory :country do
    country_code { Faker::Code.imei }
    association :panel_provider
  end
end
