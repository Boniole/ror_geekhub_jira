module Deskable
  extend ActiveSupport::Concern
  include Validatable

  included do

    validate_name
  end

  def create_columns
    Validatable::RANGE_COLUMN_NAMES.each { |name| columns.create(name: name) }
  end

  def restore_columns
    self.columns.only_deleted.each do |column|
      column.restore
      self.increment!(:columns_count)
    end
  end
end