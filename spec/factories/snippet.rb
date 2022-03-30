# frozen_string_literal: true

FactoryBot.define do
  factory :snippet do
    input_key { 'name' }
    input_value { 'value' }
    account
  end
end
