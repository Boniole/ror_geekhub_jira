# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  def index?
    false
  end

  add alias_method :show?, :index?
  add alias_method :create?, :index?
  add alias_method :new?, :index?
  add alias_method :update?, :index?
  add alias_method :edit?, :index?
  add alias_method :destroy?, :index?
end
