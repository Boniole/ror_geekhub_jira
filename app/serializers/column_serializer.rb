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
#  desk_id         :bigint           not null
#
# Indexes
#
#  index_columns_on_columnable  (columnable_type,columnable_id)
#  index_columns_on_desk_id     (desk_id)
#
# Foreign Keys
#
#  fk_rails_...  (desk_id => desks.id)
#
class ColumnSerializer < ActiveModel::Serializer
  attributes :name

  has_one :desk, serializer: DeskSerializer
  has_many :tasks, serializer: TaskSerializer
end