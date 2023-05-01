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
  include Columnable

  belongs_to :desk
  has_many :tasks, dependent: :destroy

  validates :ordinal_number, numericality: { only_integer: true }, allow_blank: true

  acts_as_paranoid

  before_create :ordinal_number
  after_create :increment_desk_column_count
  after_destroy :decrement_desk_column_count

  after_restore :restore_tasks
end
