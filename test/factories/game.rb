#game.rb
require 'faker'

FactoryGirl.define do
  factory :game do
    game_number {Faker::Number.number(2)}
    home_team_id {Faker::Number.between(1, 14)}
    away_team_id {Faker::Number.between(1, 14)}
    game_date {Faker::Date.forward(150)}
    home_goals {Faker::Number.between(1, 10)}
    away_goals {Faker::Number.between(1, 10)}
    state 'open'
    current false
    evaluated false
  end
end