FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:display_name) { |n| "user#{n}" }
    birthday Date.parse("21/6/1988")
    password "hungry"

    factory :straight_male_user do
      after(:create) do |user|
        user.create_user_detail(zipcode: "20036", gender_preference: "women", gender: "male")
      end
    end

    factory :straight_female_user do
      after(:create) do |user|
        user.create_user_detail(zipcode: "20036", gender_preference: "men", gender: "female")
      end
    end

    factory :bisexual_male_user do
      after(:create) do |user|
        user.create_user_detail(zipcode: "20036", gender_preference: "both", gender: "male")
      end
    end

    factory :bisexual_female_user do
      after(:create) do |user|
        user.create_user_detail(zipcode: "20036", gender_preference: "both", gender: "female")
      end
    end

    factory :gay_female_user do
      after(:create) do |user|
        user.create_user_detail(zipcode: "20036", gender_preference: "women", gender: "female")
      end
    end

    factory :gay_male_user do
      after(:create) do |user|
        user.create_user_detail(zipcode: "20036", gender_preference: "men", gender: "male")
      end
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