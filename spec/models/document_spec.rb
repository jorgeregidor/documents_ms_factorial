# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  before(:each) do
    Document.destroy_all
  end

  it 'is valid' do
    doc = build(:document)
    expect(doc).to be_valid
  end

  it 'is not valid for status' do
    doc = build(:document, status: nil)
    expect(doc).not_to be_valid
  end

  it 'is not valid for account' do
    doc = build(:document, account: nil)
    expect(doc).not_to be_valid
  end

  it 'find one by user_id' do
    doc = build(:document)
    doc.save
    docs = Document.filter_by_user_id(doc.owner_id)

    expect(docs.size).to eq(1)
  end

  it 'find one by status ' do
    doc = build(:document)
    doc.save
    docs = Document.filter_by_user_id(doc.owner_id)

    expect(docs.size).to eq(1)
  end

  it 'find one by status deleted ' do
    doc = build(:document, status: 'deleted')
    doc.save
    docs = Document.fetch_all({ status: 'deleted' })

    expect(docs.size).to eq(1)
  end

  it 'find zero with one deleted ' do
    doc = build(:document, status: 'deleted')
    doc.save
    docs = Document.fetch_all({})

    expect(docs.size).to eq(0)
  end
end
