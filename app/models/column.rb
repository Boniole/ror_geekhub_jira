# == Schema Information
#
# Table name: columns
#
#  id                :bigint           not null, primary key
#  columnntable_type :string           not null
#  name              :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  columnntable_id   :bigint           not null
#
# Indexes
#
#  index_columns_on_columnntable  (columnntable_type,columnntable_id)
#
class Column < ApplicationRecord
  belongs_to :columnable, polymorphic: true

  validates :name, presence: true, length: { in: 3..14 }
end
