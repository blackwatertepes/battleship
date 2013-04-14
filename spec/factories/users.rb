# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Joe Doe"
    sequence(:email) {|n| "user#{n}@mail.com" }
  end
end
