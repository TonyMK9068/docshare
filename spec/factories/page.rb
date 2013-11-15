FactoryGirl.define do
  factory :page do
  title "hello world"
  sequence(:body) { |n| "hello world test#{n}" }
  end
end