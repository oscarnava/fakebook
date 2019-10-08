# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    username { Faker::Name.unique.first_name + Faker::Name.unique.middle_name }
    email { Faker::Internet.unique.email }
    password { Faker::Lorem.characters(number: 10) }
  end
end
