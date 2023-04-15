# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end
  # add     alias_method :show?, :index?
  # add     alias_method :create?, :index?
  # add     alias_method :update?, :index?
  # add     alias_method :destroy?, :index?
  # add     alias_method :show?, :index?

  # need delete show? because 14 string
  def show?
    false
  end

  # need delete
  def create?
    false
  end

  def new?
    create?
  end

  # need delete
  def update?
    false
  end

  def edit?
    update?
  end

  # need delete
  def destroy?
    false
  end

  # mote to up(first method)
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
end
