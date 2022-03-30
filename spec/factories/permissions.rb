# frozen_string_literal: true

FactoryBot.define do
  factory :permission do
    read { true }
    write { true }
    user_id { 'abcd' }
    document
  end
end
