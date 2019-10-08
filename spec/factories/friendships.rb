# frozen_string_literal: true

FactoryGirl.define do
  factory :friendship do
    status { :pending }
    requester { create(:user) }
    requestee { create(:user) }
  end
end
