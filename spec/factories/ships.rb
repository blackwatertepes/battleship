# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ship do
    board
    name ["Destroyer", "Patrol Boat"].sample
    length { 1 + rand(5) }
    direction ["down", "right"].sample
    x { rand(10) }
    y { rand(10) }
  end
end
