# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    owner_id { '1234' }
    name { 'name' }
    account
  end
end
