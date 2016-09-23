FactoryGirl.define do
  factory :panel_provider do
    code { Faker::Code.imei }
  end
end
