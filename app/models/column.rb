# == Schema Information
#
# Table name: columns
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  name           :text
#  ordinal_number :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  desk_id        :bigint           not null
#
# Indexes
#
#  index_columns_on_deleted_at  (deleted_at)
#  index_columns_on_desk_id     (desk_id)
#
# Foreign Keys
#
#  fk_rails_...  (desk_id => desks.id)
#
class Column < ApplicationRecord
  include Validatable::Columnable

  belongs_to :desk
  has_many :tasks, dependent: :destroy

  validates :ordinal_number, numericality: { only_integer: true }, allow_blank: true

  acts_as_paranoid

  before_create :ordinal_number
  after_create :increment_desk_column_count
  after_destroy :decrement_desk_column_count

  def increment_desk_column_count
    desk.increment!(:columns_count)
  end

  def decrement_desk_column_count
    desk.decrement!(:columns_count)
  end

  def ordinal_number
    self.ordinal_number = desk.columns_count
  end
end
