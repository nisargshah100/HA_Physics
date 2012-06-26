FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password "hungry"

    after_create do |user|
      zip = Zip.create(city: "Washington", state: "DC")
      user.create_user_detail(display_name: "Ed", zip: zip)
    end
  end

  factory :user_with_events, parent: :user do
    ignore do
      event_count 2
    end

    after_create do |user, evaluator|
      FactoryGirl.create_list(
        :event,
        evaluator.event_count,
        user: user)
    end
  end
end