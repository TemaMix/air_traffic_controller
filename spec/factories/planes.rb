FactoryGirl.define do
  factory :plane do
    sequence(:name) { |n| "name-#{n}" }
  end
end
