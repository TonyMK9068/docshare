FactoryGirl.define do
  factory :user do
    username "whatever"
    email "person@example.com"
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end