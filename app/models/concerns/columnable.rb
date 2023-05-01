module Columnable
  extend ActiveSupport::Concern
  include Validatable

  included do
    validate_name
  end

  def increment_desk_column_count
    desk.increment!(:columns_count)
  end

  def decrement_desk_column_count
    desk.decrement!(:columns_count)
  end

  def ordinal_number
    self.ordinal_number = desk.columns_count
  end

  def restore_tasks
    self.tasks.only_deleted.each { |task| task.restore }
  end
end