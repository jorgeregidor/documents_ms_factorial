# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    super
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    record.owner_id == user.id
  end

  def update?
    show?
  end
end
