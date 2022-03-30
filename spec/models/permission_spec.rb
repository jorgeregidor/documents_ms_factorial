# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Permission, type: :model do
  it 'is valid' do
    per = build(:permission)
    expect(per).to be_valid
  end
end
