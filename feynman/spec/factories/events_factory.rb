FactoryGirl.define do
  factory :event do
    ignore do
      user
    end

    deal_id "1"
    description "The Park at 14th - $50 to Spend on Food and Drink"
    date nil
  
    factory :livingsocial_event do
      source "LivingSocial"
    end

    factory :groupon_event do
      source "groupon"
    end
  end
end