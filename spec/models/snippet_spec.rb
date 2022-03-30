# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Snippet, type: :model do
  it 'is valid' do
    snippet = build(:snippet)
    expect(snippet).to be_valid
  end
end
