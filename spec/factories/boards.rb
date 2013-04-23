# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :board do
    cells 10
    rows 10
    game 
    user
    
    after(:build) {|n| n.gridify }
  end
end
