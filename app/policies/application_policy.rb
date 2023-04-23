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

  alias_method :show?, :index?
  alias_method :create?, :index?
  alias_method :new?, :index?
  alias_method :update?, :index?
  alias_method :edit?, :index?
  alias_method :destroy?, :index?
end
