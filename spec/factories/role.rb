# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :role do
    status "owner"
    page_id
    user_id
  end
end
