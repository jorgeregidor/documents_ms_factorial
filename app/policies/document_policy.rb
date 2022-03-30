# frozen_string_literal: true

class DocumentPolicy < ApplicationPolicy
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
    record.owner_id == user.id || can_read?
  end

  def update?
    record.owner_id == user.id || can_write?
  end

  def create?
    true
  end

  def destroy?
    record.owner_id == user.id
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      super
      @user  = user
      @scope = scope
    end

    def resolve
      scope.filter_by_user_id(user.id)
    end
  end

  private

  def can_read?
    record.permissions.where(user_id: user.id, read: true).present? || can_write?
  end

  def can_write?
    record.permissions.where(user_id: user.id, write: true).present?
  end
end
