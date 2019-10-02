# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 10) }
  end
end
