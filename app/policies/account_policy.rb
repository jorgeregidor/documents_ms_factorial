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

  def create?
    true
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      super
      @user  = user
      @scope = scope
    end

    def resolve
      scope.find_by(owner_id: user.id)
    end
  end
end
