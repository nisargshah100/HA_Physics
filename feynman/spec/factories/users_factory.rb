FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:display_name) { |n| "user#{n}" }
    birthday Date.parse("21/6/1988")
    password "hungry"

    after(:create) do |user|
      user.create_user_detail(zipcode: "20036")
    end
  end

  factory :user_with_events, parent: :user do
    ignore do
      event_count 2
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list(
        :event,
        evaluator.event_count,
        user: user)
    end
  end
end