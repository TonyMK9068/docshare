FactoryGirl.define do
  factory :user do
    username "Super Man"
    email "person@example.com"
    password "testpass"
    password_confirmation "testpass"
    confirmed_at Time.now
  end
end