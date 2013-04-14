# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    board_user ""
    board_comp ""
    winner ""
    user

    after(:build) {|i| i.new_boards }
  end
end
