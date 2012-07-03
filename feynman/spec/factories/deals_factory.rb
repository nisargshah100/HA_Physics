FactoryGirl.define do
  factory :deal do
    latitude 38.90812
    longitude -77.041659
    last_purchase_count 10
    price_cents 100
    value_cents 100
    sequence(:original_id) { |n| "#{n}ABC" }

    factory :expired_deal do
      end_date Time.now - 100
    end

    factory :active_deal do
      end_date Time.now + 100
    end

    factory :popular_deal do
      last_purchase_count 1000
    end

    factory :cali_deal do
      latitude 36.488
      longitude -119.701
    end
  end
end