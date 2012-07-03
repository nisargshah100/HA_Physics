FactoryGirl.define do
  factory :message do
    ignore do
      association :sender, factory: :user
      association :recipient, factory: :user
    end
    
    body "This is a message."
  end
end