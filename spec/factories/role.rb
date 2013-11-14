# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
    status "owner"
    page_id
    user_id
  end
end
