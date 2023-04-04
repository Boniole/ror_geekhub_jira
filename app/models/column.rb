# == Schema Information
#
# Table name: columns
#
#  id              :bigint           not null, primary key
#  columnable_type :string           not null
#  name            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  columnable_id   :bigint           not null
#
# Indexes
#
#  index_columns_on_columnable  (columnable_type,columnable_id)
#
class Column < ApplicationRecord
  belongs_to :columnable, polymorphic: true
  has_many :tasks

  validates :name, presence: true, length: { in: 3..14 }
end
