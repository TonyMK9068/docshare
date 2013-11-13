# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
    user 'user'
    page 'page'
    status "owner"
  end
end
