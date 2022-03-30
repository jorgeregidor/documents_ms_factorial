# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'create a new account' do
    owner_id = '1234'
    account = Account.by_user_id(owner_id)
    expect(account.uuid).not_to eq(nil)
    expect(account.owner_id).to eq(owner_id)
  end

  it 'validate uniqueness owner_id' do
    account1 = build(:account)
    account2 = build(:account)
    account1.save
    expect(account2).not_to be_valid
  end
end
