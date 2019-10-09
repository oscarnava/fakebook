# frozen_string_literal: true

FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    user { create(:user) }
    post { create(:post) }
  end
end
