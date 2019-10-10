# frozen_string_literal: true

FactoryGirl.define do
  factory :post do
    user { create(:user) }
    content { Faker::Lorem.paragraph }
  end
end
