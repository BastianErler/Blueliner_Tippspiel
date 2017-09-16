#game.rb
require 'faker'

FactoryGirl.define do
  factory :tip do
    game_id {Faker::Number.between(1, 50)}
    user_id {Faker::Number.between(1, 20)}
    home_goals {Faker::Number.between(1, 10)}
    away_goals {Faker::Number.between(1, 10)}
  end
end