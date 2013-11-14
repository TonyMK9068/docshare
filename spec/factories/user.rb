FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "tester#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end