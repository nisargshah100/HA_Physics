FactoryGirl.define do
  factory :user do
    sequence(:display_name) { |n| "displayname#{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password "hungry"
  end
end