FactoryGirl.define do
  factory :target_group do
    name { Faker::Address.city }
    association :panel_provider
  end
end
