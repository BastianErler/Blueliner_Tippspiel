#user.rb
require 'faker'

FactoryGirl.define do
  factory :user do
    name {Faker::GameOfThrones.unique.character}
    email {Faker::Internet.unique.email}
    password_digest 'password'
    remember_digest {Faker::Lorem.word}
    admin false
    activation_digest {Faker::Lorem.word}
    activated true
    activated_at Time.now()
    guest false
  end
end